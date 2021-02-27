
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/constants/chat_list.dart' as chat_list;
import 'package:uber_clone/constants/message.dart' as message_fields;
import 'package:uber_clone/models/chat_info.dart';
import 'package:uber_clone/models/message.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/secure_storage.dart';
class ChatProvider {

  final String userId = FirebaseAuth.instance.currentUser.uid;
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  final CollectionReference _chatReference = FirebaseFirestore.instance.collection('chats');
  final CollectionReference _usersReference = FirebaseFirestore.instance.collection('users');
  final ChatInfo chatInfo;



  ChatProvider({@required this.chatInfo});

  Future<void> sendMessage(Message message) async {

    Map<String, dynamic> snapshot = _buildMessage(message);

     await _instance.runTransaction((transaction) async {
       transaction.set(_chatReference.doc(chatInfo.chatId).collection('messages').doc(DateTime.now().millisecondsSinceEpoch.toString()), snapshot);
     });


     // first we need to setup creation


     await _instance.runTransaction((transaction) async {
       transaction.update(_usersReference.doc(userId).collection('chats').doc(chatInfo.chatId), {
         chat_list.lastMessage : message.message,
         chat_list.lastMessageTimestamp : message.timestamp,
         chat_list.lastMessageSenderFirebaseId : userId
       });
     });


     await _instance.runTransaction((transaction) async {
       transaction.update(_usersReference.doc(chatInfo.firebaseUserId).collection('chats').doc(chatInfo.chatId), {
         chat_list.lastMessage : message.message,
         chat_list.lastMessageTimestamp : message.timestamp,
         chat_list.lastMessageSenderFirebaseId : userId
       });
     });


  }


  Map<String, dynamic> _buildMessage(Message message) {
    return {
      message_fields.firebaseUserId   :  userId,
      message_fields.message          : message.message,
      message_fields.timestamp        : message.timestamp
    };
  }


  Future<void> createChat() async {

    //first we check are the collections already created
    DocumentSnapshot chatHistory = await _usersReference.doc(this.userId).collection('chats').doc(chatInfo.chatId).get();
    // chat collections are already created, even if there aren't any messages exhanged
    if(chatHistory.exists) {
      return;
    }

    UserData userData = await SecureStorage.loadUser();

    // if not, we need to create three new collections


    _instance.runTransaction((transaction) async {
      transaction.set(_chatReference.doc(chatInfo.chatId), {
        'firebaseUserId1' : this.userId,
        'firebaseUserId2' : userId,
      });
    });




    //chat list of current user
    _instance.runTransaction((transaction) async {
      transaction.set(_usersReference.doc(this.userId).collection('chats').doc(chatInfo.chatId), {
          chat_list.firebaseUserId              : chatInfo.firebaseUserId,
          chat_list.firstName                   : chatInfo.firstName,
          chat_list.lastName                    :  chatInfo.lastName,
          chat_list.lastMessage                 : '',
          chat_list.lastMessageTimestamp        : null,
          chat_list.lastMessageSenderFirebaseId : null
      });
    });

    //chat list of driver the user is chatting with
    _instance.runTransaction((transaction) async {
      transaction.set(_usersReference.doc(chatInfo.firebaseUserId).collection('chats').doc(chatInfo.chatId), {
        chat_list.firebaseUserId              : this.userId,
        chat_list.firstName                   : userData.firstName,
        chat_list.lastName                    : userData.lastName,
        chat_list.lastMessage                 : '',
        chat_list.lastMessageTimestamp        : null,
        chat_list.lastMessageSenderFirebaseId : null
      });
    });





  }

  




}