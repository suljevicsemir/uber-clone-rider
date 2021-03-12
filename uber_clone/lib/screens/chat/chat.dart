import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:uber_clone/models/chat_info.dart';
import 'package:uber_clone/models/message.dart';
import 'package:uber_clone/providers/chat_provider.dart';
class Chat extends StatefulWidget {

  static const route = '/chat';
  final ChatInfo chatInfo;
  final File picture;

  Chat({@required this.chatInfo, this.picture});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {



  ChatProvider chatProvider;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    chatProvider = ChatProvider(chatInfo: widget.chatInfo);

     KeyboardVisibilityNotification().addNewListener(
       onChange: (bool visible) async {
         if(visible)  {
           await Future.delayed(const Duration(milliseconds: 30));
           _scrollChatToBottom();
         }
       }
     );

  }


  _scrollChatToBottom() {

    if(scrollController.hasClients) {
      scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 120)
      );
    }
    else {
      Timer(const Duration(milliseconds: 40), () => _scrollChatToBottom());
    }
  }



  @override
  Widget build(BuildContext context) {
    _scrollChatToBottom();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.chatInfo.firstName),
        actions: [
          IconButton(icon: Icon(Icons.call), onPressed: () {
          })
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).viewInsets.bottom + 96,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('chats').doc(widget.chatInfo.chatId).collection('messages').limit(100).snapshots(),
                builder: (context, snapshot)  {
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
                      child: Text('There are no messages'),
                    );
                  }
                  return Container(
                    child: ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) => _buildMessage(context, Message.fromSnapshot(snapshot.data.docs[index]))
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
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 800),
                          child: IconButton(
                              splashColor: Colors.red,
                              splashRadius: 25,
                              padding: EdgeInsets.all(8),
                              color: Colors.yellow,
                              onPressed: () async{
                                Timestamp timestamp = Timestamp.now();
                                Message message = Message(message: textController.text, timestamp: timestamp);
                                textController.clear();
                                await chatProvider.sendMessage(message);
                                _scrollChatToBottom();
                              },
                              icon: Icon(Icons.send)
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(Icons.animation),
                        ),
                        IconButton(icon: Icon(Icons.ac_unit), onPressed: () {})
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      )
    );
  }
  
  _buildMessage(BuildContext context, Message message ) {
    bool sentMessage = message.firebaseUserId == FirebaseAuth.instance.currentUser.uid ? true : false;
    return Align(
      alignment: sentMessage == true ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        children: [
          CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.transparent,
              backgroundImage: FileImage(widget.picture),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: sentMessage == true ? EdgeInsets.only(right: 10, bottom: 10) : EdgeInsets.only(left: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20)
            ),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.5
            ),
            child: Text(message.message, style: TextStyle(color: Colors.black, fontSize: 20),),
          ),
        ],
      )
    );
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }


}
