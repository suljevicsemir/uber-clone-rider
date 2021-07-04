



import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/services/firebase/authentication/authentication_client.dart';

abstract class FirestoreClient {
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  late CollectionReference _chatReference;
  late CollectionReference _usersReference;
  late CollectionReference _driversReference;
  late CollectionReference _accountSettingsReference;

  FirestoreClient() {
    _chatReference            = instance.collection("chats");
    _usersReference           = instance.collection("users");
    _driversReference         = instance.collection("drivers");
    _accountSettingsReference = instance.collection("account_settings");
  }

  Future<DocumentSnapshot> getChat(String driverId) async {
    return await _chatReference.doc(driverId).get();
  }



  DocumentReference getDriverChat(String driverId, String chatId) {
    return _driversReference.doc(driverId).collection("chats").doc(chatId);
  }

  DocumentReference getUserChat(String chatId) {
    return _driversReference.doc(AuthenticationClient.id).collection("chats").doc(chatId);
  }

  CollectionReference get driversReference => _driversReference;

  CollectionReference get usersReference => _usersReference;

  CollectionReference get chatReference => _chatReference;



  DocumentReference get accountSettingsReference => _accountSettingsReference.doc(AuthenticationClient.id);
  DocumentReference get accountReference => _usersReference.doc(AuthenticationClient.id);
}