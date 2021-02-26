import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/constants/message.dart' as message_fields;
import 'package:uber_clone/models/chat_info.dart';
import 'package:uber_clone/models/message.dart';
class ChatProvider {

  final String userId = FirebaseAuth.instance.currentUser.uid;
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  final CollectionReference _chatReference = FirebaseFirestore.instance.collection('chats');
  final CollectionReference _usersReference = FirebaseFirestore.instance.collection('users');
  final ChatInfo chatInfo;

  double test = 12.0;

  ChatProvider({@required this.chatInfo});

  Future<void> sendMessage(Message message) async {

    Map<String, dynamic> snapshot = _buildMessage(message);

     await _instance.runTransaction((transaction) async {
       transaction.set(_chatReference.doc(chatInfo.chatId).collection('messages').doc(DateTime.now().millisecondsSinceEpoch.toString()), snapshot);
     });

     /*await _instance.runTransaction((transaction) async {
       transaction.update(_usersReference.doc(userId).collection('chats').doc(chatInfo.chatId), {
         chat_fields.lastMessage : message.content,
         chat_fields.lastMessageTimestamp : message.timestamp,
         chat_fields.lastMessageSenderFirebaseId : userId
       });
     });


     await _instance.runTransaction((transaction) async {
       transaction.update(_usersReference.doc(chatInfo.firebaseUserId).collection('chats').doc(chatInfo.chatId), {
         chat_fields.lastMessage : message.content,
         chat_fields.lastMessageTimestamp : message.timestamp,
         chat_fields.lastMessageSenderFirebaseId : userId
       });
     });*/


  }


  Map<String, dynamic> _buildMessage(Message message) {
    return {
      message_fields.firebaseUserId   :  userId,
      message_fields.message          : message.message,
      message_fields.timestamp        : message.timestamp
    };
  }




}