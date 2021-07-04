import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uber_clone/constants/chat_list.dart' as chat_list_fields;
import 'package:uber_clone/getx_controllers/user_data.dart';
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/models/firestore_result.dart';
import 'package:uber_clone/models/message.dart';
import 'package:uber_clone/services/firebase/authentication/authentication_client.dart';
import 'package:uber_clone/services/firebase/firestore/firestore_client.dart';



class ChatClient extends FirestoreClient {

  // load user data from a getx controller

  UserDataController userDataController = Get.find();

  ChatClient(): super();

  Future<FirestoreResult> createChatWithDriver(Driver driver) async {

    String userId = AuthenticationClient.id;
    String chatId = "chat" + (driver.id.compareTo(userId) < 0 ? (driver.id + userId) : (userId + driver.id));

    try {
      DocumentSnapshot chatHistory = await chatReference
          .doc(chatId)
          .get()
          .timeout(const Duration(seconds: 3));

      await instance.runTransaction((transaction) async{
        transaction.set(chatReference.doc(chatId), {
          'firebaseUserId1' : userId,
          'firebaseUserId2' : driver.id,
        });

        transaction.set( super.getUserChat(chatId), {
          chat_list_fields.firebaseUserId : driver.id,
          chat_list_fields.firstName      : driver.firstName,
          chat_list_fields.lastName       : driver.lastName
        });

        transaction.set( super.getDriverChat(driver.id, chatId), {
          chat_list_fields.firebaseUserId : userDataController.user.firebaseUserId,
          chat_list_fields.firstName      : userDataController.user.firstName,
          chat_list_fields.lastName       : userDataController.user.lastName
        });

      })
      .timeout(const Duration(seconds: 3));

      return FirestoreResult(value: chatHistory);
    }
    on TimeoutException catch(error) {
      return FirestoreResult(value: error);
    }
    on Exception catch(error) {
      return FirestoreResult(value: error);
    }

  }


  Future<void> sendMessage(Message message) async {

    chatReference.doc(message.chatId).collection("messages").add(message.toJson());


    usersReference.doc(message.firebaseUserId).collection("chats").doc(message.chatId).update({
      chat_list_fields.lastMessage                  : message.message,
      chat_list_fields.lastMessageTimestamp         : message.timestamp,
      chat_list_fields.lastMessageSenderFirebaseId  : userDataController.user.firebaseUserId
    });

    driversReference.doc(message.driverId).collection("chats").doc(message.chatId).update({
      chat_list_fields.lastMessage                  : message.message,
      chat_list_fields.lastMessageTimestamp         : message.timestamp,
      chat_list_fields.lastMessageSenderFirebaseId  : userDataController.user.firebaseUserId
    });

  }



}