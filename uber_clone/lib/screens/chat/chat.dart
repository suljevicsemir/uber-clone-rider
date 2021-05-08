import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:uber_clone/screens/driver_profile/driver_profile.dart';
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
  bool shouldLoadPicture = false;

  late Driver driver;


  @override
  void initState() {
    super.initState();
    _scrollChatToBottom();
    setState(() {
      driver = widget.driver;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('did change depedencies');

    if( !shouldLoadPicture) {
      print('loading picture');

      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async{
        setState(() {
          picture = Provider.of<ProfilePicturesProvider>(context, listen: false).driverProfilePictures![widget.driver.id];
          shouldLoadPicture = true;
        });
      });

      String chatId = Provider.of<ChatProvider>(context, listen: false).chatId;

      // sigurno postoji
      FirebaseFirestore.instance.collection('drivers').doc(widget.driver.id).snapshots().listen((DocumentSnapshot driverSnapshot) {

        FirebaseFirestore.instance.collection('chats').doc(chatId).snapshots().listen((DocumentSnapshot chatSnapshot) async{

          // vjerovatno bi svakako error bio
          if(!chatSnapshot.exists) {
            print('chat ne postoji');
            return;
          }


          // prvi put se chat otvara
          if( !chatSnapshot.data()!.containsKey(FirebaseService.id)) {
            print('ne postoji');
            await FirebaseService.firestoreInstance.runTransaction((transaction) async{
              DocumentSnapshot driver = await transaction.get(FirebaseService.firestoreInstance.collection('drivers').doc(widget.driver.id));
              String url = driver.get('profilePictureUrl');

              transaction.update(FirebaseService.firestoreInstance.collection('chats').doc(chatId), {
                FirebaseService.id : url
              });
            });
            return;
          }

          print('exists');
          if( driverSnapshot.get('profilePictureUrl') != chatSnapshot.get(FirebaseService.id)) {
            File? updatePicture = await Provider.of<ProfilePicturesProvider>(context, listen: false).
            updateDriverPicture(driverId: widget.driver.id, chatId: chatId, url: driverSnapshot.get('profilePictureUrl'));
            setState(() {
              picture = updatePicture;
            });
          }
        });
      });

    }
  }

  _scrollChatToBottom() {

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
                stream: FirebaseFirestore.instance.collection('chats').doc(Provider.of<ChatProvider>(context, listen: false).chatId).collection('messages').orderBy('timestamp').limitToLast(20).snapshots(),
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
                        itemBuilder: (context, index) =>
                            snapshot.data.docs[index].get('firebaseUserId') != FirebaseService.id ?
                            ReceivedMessage(
                            message: Message.fromSnapshot(snapshot.data.docs[index]),
                            nextMessage: index < docsLength - 1 ? Message.fromSnapshot(snapshot.data.docs[index + 1]) : null,
                            isLast: index == docsLength - 1,
                            driver: widget.driver,
                            )
                            :
                            SentMessage(
                              message: Message.fromSnapshot(snapshot.data.docs[index]),
                            )
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

  _buildMessage(BuildContext context, Message message, Message? nextMessage, bool isLast) {

    bool isNextSent = false;
    bool sentMessage = message.firebaseUserId == FirebaseAuth.instance.currentUser!.uid ? true : false;
    if( nextMessage != null) {
      isNextSent = nextMessage.firebaseUserId == FirebaseAuth.instance.currentUser!.uid;
    }

    bool shouldHavePicture = (isNextSent && !sentMessage) || (isLast && !sentMessage);



    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: sentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        shouldHavePicture ? GestureDetector(
          onTap: () async {
            await Navigator.pushNamed(context, DriverProfile.route, arguments: widget.driver.id);
          },
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Colors.transparent,
              backgroundImage: FileImage(picture!),
            ),
          ),
        ):
        Container() ,
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          margin: (sentMessage) ? EdgeInsets.only(right: 10, bottom: 10) : shouldHavePicture ? EdgeInsets.only(bottom: 10, left: 7) :  EdgeInsets.only(left: 39 , bottom: 10),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20)
          ),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.5
          ),
          child: Text(message.message, style: TextStyle(color: Colors.black, fontSize: 17),),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    controller.dispose();
  }
}