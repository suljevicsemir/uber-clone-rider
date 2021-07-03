import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/models/message.dart';
import 'package:uber_clone/providers/chat_provider.dart';
import 'package:uber_clone/providers/profile_pictures_provider.dart';
import 'package:uber_clone/screens/chat/chat_app_bar.dart';
import 'package:uber_clone/screens/chat/chat_keyboard.dart';
import 'package:uber_clone/screens/chat/messages/received_message.dart';
import 'package:uber_clone/screens/chat/messages/sent_message.dart';
import 'package:uber_clone/services/firebase/firebase_service.dart';

class Chat extends StatefulWidget {

  static const route = '/chat';

  final Driver driver;


  Chat({required this.driver});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  File? picture;
  bool isFirstRun = true;

  late Driver driver;
  String? variable;

  @override
  void initState() {
    super.initState();
    _scrollChatToBottom();



    driver = widget.driver;

  }

  late String chatId;


  late Stream<QuerySnapshot> chat;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('did change depedencies');

    if( isFirstRun) {
      print('first load of the screen');




      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {

        print('scheduler is called');
        setState(() {
          picture = Provider.of<ProfilePicturesProvider>(context, listen: false).driverProfilePictures![widget.driver.id];
          isFirstRun = false;
          this.chatId = Provider.of<ChatProvider>(context, listen: false).chatId;
          chat = FirebaseFirestore.instance
              .collection('chats')
              .doc(this.chatId)
              .collection('messages')
              .orderBy('timestamp').limitToLast(190)
              .snapshots();
        });
      });

      String chatId = Provider.of<ChatProvider>(context, listen: false).chatId;


/*
     if(DateTime.now().hour >= 0 && DateTime.now().hour <= 23) {
        SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
          print('getting driver document...');

          DocumentSnapshot driver = await FirebaseService.firestoreInstance.collection('drivers').doc(widget.driver.id).get();
          DocumentSnapshot cachedRider = await FirebaseService.firestoreInstance.collection('chats').doc(chatId).get();


          if(!cachedRider.data()!.containsKey(FirebaseService.id)) {
            await cachedRider.reference.update({
              FirebaseService.id : driver.get('profilePictureUrl')
            });
            await Provider.of<ProfilePicturesProvider>(context, listen: false).updateDriverPicture(driverId: driver.id, chatId: chatId, url: driver.get('profilePictureUrl'));
          }

          else if( driver.get('profilePictureUrl') != cachedRider.get(FirebaseService.id)) {
              await Provider.of<ProfilePicturesProvider>(context, listen: false).
              updateDriverPicture(driverId: driver.id, chatId: chatId, url: driver.get('profilePictureUrl'));
          }

        });
      }

*/

    }
  }

  void _scrollChatToBottom() {

    if(scrollController.hasClients) {
      scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 50)
      );
    }
    else {
      Timer(const Duration(milliseconds: 40), () => _scrollChatToBottom());
    }
  }


  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    if( picture == null)
      return Container();
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: ChatAppBar(driver: widget.driver,),
        ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).viewInsets.bottom + 55,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: StreamBuilder(
                stream: chat,
                builder: (context, AsyncSnapshot snapshot)  {

                  if(!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if( snapshot.data.docs.isEmpty) {
                    //create chat in chats collection and in users-chats
                    Provider.of<ChatProvider>(context, listen: false).createChat();
                    return Center(
                      child: Text('No messages with ' + widget.driver.firstName + ' ' + widget.driver.lastName)
                    );
                  }
                  Timer(const Duration(milliseconds: 100), () => {
                    _scrollChatToBottom()
                  });
                  int docsLength = snapshot.data.docs.length;
                  return Container(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {

                          DocumentSnapshot x = snapshot.data.docs[index];
                          if(x.metadata.isFromCache) {
                            print('from cache: ' + x.get('message'));
                          }
                          else {
                            print('from server: ' + x.get('message'));
                          }

                          return snapshot.data.docs[index].get('firebaseUserId') !=
                              FirebaseService.id ?
                          ReceivedMessage(
                            message: Message.fromSnapshot(
                                snapshot.data.docs[index]),
                            nextMessage: index < docsLength - 1
                                ? Message.fromSnapshot(
                                snapshot.data.docs[index + 1])
                                : null,
                            isLast: index == docsLength - 1,
                            driver: widget.driver,
                          ) :
                          SentMessage(
                            message: Message.fromSnapshot(
                                snapshot.data.docs[index]),
                          );
                        }
                    ),
                  );
                },
              ),
            ),
          ),
          ChatKeyboard(),
        ],
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();

    controller.dispose();
  }
}