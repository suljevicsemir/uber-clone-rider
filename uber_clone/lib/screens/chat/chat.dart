import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/models/message.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/providers/chat_provider.dart';
import 'package:uber_clone/providers/profile_pictures_provider.dart';
import 'package:uber_clone/providers/user_data_provider.dart';
import 'package:uber_clone/screens/driver_contact/driver_contact.dart';
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';


class Chat extends StatefulWidget {

  static const route = '/chat';

  final Driver driver;


  Chat({required this.driver});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {



  late ChatProvider chatProvider;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  File? picture;

  bool hasText = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    textController.addListener(() {
      if(textController.text.isNotEmpty && !hasText) {
        setState(() {
          hasText = true;
        });
      }
      if( textController.text.isEmpty && hasText) {
        setState(() {
          hasText = false;
        });
      }
    });

    UserData x = Provider.of<UserDataProvider>(context, listen: false).userData!;
    chatProvider = ChatProvider(driver: widget.driver, userData: x);
    _scrollChatToBottom();
    picture = Provider.of<ProfilePicturesProvider>(context, listen: false).driverProfilePictures![widget.driver.id];
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



  @override
  Widget build(BuildContext context) {
    if( picture == null)
      return Container();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        title: GestureDetector(
          onTap: () async => await Navigator.pushNamed(context, DriverContact.route, arguments: widget.driver),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 17,
                backgroundImage: FileImage(picture!),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(width: 10,),
              Text(widget.driver.firstName)
            ],
          ),
        ),
        actions: [
          //CallNumber(phoneNumber: widget.driver.phoneNumber)
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).viewInsets.bottom + 55,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('chats').doc(chatProvider.chatId).collection('messages').limit(100).snapshots(),
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
                    chatProvider.createChat();
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
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) => _buildMessage(context, Message.fromSnapshot(snapshot.data.docs[index]),
                            index < docsLength - 1 ? Message.fromSnapshot(snapshot.data.docs[index + 1]) : null,
                            index == docsLength - 1)

                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                //color: Colors.blue,
                  border: Border(
                      top: BorderSide(
                          width: 0.5,
                          color: Colors.grey
                      )
                  )
              ),
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 8),
                            child: TextField(
                              controller: textController,
                              decoration: InputDecoration(
                                  hintText: 'Type a message...',
                                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 19),
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 3)
                                  ),
                                  enabledBorder: InputBorder.none
                              ),
                              cursorColor: Colors.yellow,
                              cursorHeight: 26,
                              cursorWidth: 2,
                            ),
                          ),
                        ),
                        textController.text.isNotEmpty  ?
                        IconButton(
                            splashColor: Colors.red,
                            splashRadius: 25,
                            padding: EdgeInsets.all(8),
                            color: Colors.black87,
                            onPressed: () async{
                              Timestamp timestamp = Timestamp.now();
                              Message message = Message(message: textController.text, timestamp: timestamp, firebaseUserId: FirebaseAuth.instance.currentUser!.uid);
                              textController.clear();
                              await chatProvider.sendMessage(message);
                              _scrollChatToBottom();
                            },
                            icon: Icon(Icons.send)
                        ) : Container()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      )
    );
  }

  _buildMessage(BuildContext context, Message message, Message? nextMessage, bool isLast) {

    bool isNextSent = false;
    bool sentMessage = message.firebaseUserId == UberAuth.userId ? true : false;
    if( nextMessage != null) {
      isNextSent = nextMessage.firebaseUserId == UberAuth.userId;
    }

    bool shouldHavePicture = (isNextSent && !sentMessage) || (isLast && !sentMessage);



    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: sentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        shouldHavePicture ? GestureDetector(
          onTap: () async {
            await Navigator.pushNamed(context, DriverContact.route, arguments: widget.driver);
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
}