import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/constants/chat_list.dart' as chat_list;
import 'package:uber_clone/constants/message.dart' as message_fields;
import 'package:uber_clone/models/chat_info.dart';
import 'package:uber_clone/models/message.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';
import 'package:uber_clone/services/firebase/firestore/firestore_service.dart';
import 'package:uber_clone/services/user_data_service.dart';

class ChatProvider {


  final FirebaseFirestore _instance = FirebaseFirestore.instance;


  final CollectionReference _usersReference = FirebaseFirestore.instance.collection('users');
  final ChatInfo chatInfo;



  ChatProvider({@required this.chatInfo});

  Future<void> sendMessage(Message message) async {

    Map<String, dynamic> snapshot = _buildMessage(message);

     await _instance.runTransaction((transaction) async {
       transaction.set(FirestoreService.chats.doc(chatInfo.chatId).collection('messages').doc(DateTime.now().millisecondsSinceEpoch.toString()), snapshot);
     });


     // first we need to setup creation


     await _instance.runTransaction((transaction) async {
       transaction.update(FirestoreService.userChats.doc(chatInfo.chatId), {
         chat_list.lastMessage                 : message.message,
         chat_list.lastMessageTimestamp        : message.timestamp,
         chat_list.lastMessageSenderFirebaseId : UberAuth.userId
       });
     });


     await _instance.runTransaction((transaction) async {
       transaction.update(FirestoreService.users.doc(chatInfo.firebaseUserId).collection('chats').doc(chatInfo.chatId), {
         chat_list.lastMessage                 : message.message,
         chat_list.lastMessageTimestamp        : message.timestamp,
         chat_list.lastMessageSenderFirebaseId : UberAuth.userId
       });
     });


  }


  Map<String, dynamic> _buildMessage(Message message) {
    return {
      message_fields.firebaseUserId   : UberAuth.userId,
      message_fields.message          : message.message,
      message_fields.timestamp        : message.timestamp
    };
  }


  Future<void> createChat() async {

    //first we check are the collections already created
    DocumentSnapshot chatHistory = await FirestoreService.userChats.doc(chatInfo.chatId).get();
    // chat collections are already created, even if there aren't any messages exchanged
    if(chatHistory.exists) {
      return;
    }

    // if not, we need to create three new collections
    UserDataService data = UserDataService();
    UserData userData = await data.loadUser();

    _instance.runTransaction((transaction) async {
      transaction.set(FirestoreService.chats.doc(chatInfo.chatId), {
        'firebaseUserId1' : UberAuth.userId,
        'firebaseUserId2' : chatInfo.firebaseUserId,
      });
    });




    //chat list of current user
    _instance.runTransaction((transaction) async {
      transaction.set(FirestoreService.users.doc(UberAuth.userId).collection('chats').doc(chatInfo.chatId), {
          chat_list.firebaseUserId              : chatInfo.firebaseUserId,
          chat_list.firstName                   : chatInfo.firstName,
          chat_list.lastName                    : chatInfo.lastName,
          chat_list.lastMessage                 : '',
          chat_list.lastMessageTimestamp        : null,
          chat_list.lastMessageSenderFirebaseId : null
      });
    });

    //chat list of driver the user is chatting with
    _instance.runTransaction((transaction) async {
      transaction.set(FirestoreService.users.doc(chatInfo.firebaseUserId).collection('chats').doc(chatInfo.chatId), {
        chat_list.firebaseUserId              : UberAuth.userId,
        chat_list.firstName                   : userData.firstName,
        chat_list.lastName                    : userData.lastName,
        chat_list.lastMessage                 : '',
        chat_list.lastMessageTimestamp        : null,
        chat_list.lastMessageSenderFirebaseId : null
      });
    });


  }

  




}