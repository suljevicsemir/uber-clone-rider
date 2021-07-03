import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/models/message.dart';
import 'package:uber_clone/service_locator.dart';
import 'package:uber_clone/services/firebase/authentication/authentication_client.dart';
import 'package:uber_clone/services/firebase/firestore/chat_client/chat_client.dart';

class ChatKeyboard extends StatefulWidget {

  final String chatId;
  final String driverId;

  ChatKeyboard({
    required this.chatId,
    required this.driverId
  });

  @override
  _ChatKeyboardState createState() => _ChatKeyboardState();
}

class _ChatKeyboardState extends State<ChatKeyboard> {

  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
            border: const Border(
                top: const BorderSide(
                    width: 0.5,
                    color: Colors.grey
                )
            )
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: const TextStyle(color: const Color(0xFF9E9E9E), fontSize: 19),
                        focusedBorder: InputBorder.none,
                        disabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red, width: 3)
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
                  padding: const EdgeInsets.all(8),
                  color: Colors.black87,
                  onPressed: () async {
                    locator.get<ChatClient>().sendMessage(
                        Message(
                          message: textController.text,
                          timestamp: Timestamp.now(),
                          firebaseUserId: locator.get<AuthenticationClient>().id,
                          chatId: widget.chatId,
                          driverId: widget.driverId));
                    textController.clear();
                  },
                  icon: const Icon(Icons.send,)
              ) :
              Container()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
