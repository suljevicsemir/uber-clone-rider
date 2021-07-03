



import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/models/firestore_result.dart';
import 'package:uber_clone/service_locator.dart';
import 'package:uber_clone/services/firebase/authentication/authentication_client.dart';

abstract class FirestoreClient {
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  late CollectionReference _chatReference;
  late CollectionReference _usersReference;
  late CollectionReference _driversReference;

  FirestoreClient() {
    _chatReference    = instance.collection("chats");
    _usersReference   = instance.collection("users");
    _driversReference = instance.collection("drivers");
  }


  Future<FirestoreResult> getSomething(Duration duration) async {
    try {
      DocumentSnapshot snapshot = await _usersReference
          .doc("PqJfYn0UHydWJSUnViveamqf6JR2")
          .get()
          .timeout(duration);
      return FirestoreResult(value: snapshot);
    }
    on TimeoutException catch(error) {

      return FirestoreResult(value: error);
    }
    on Exception catch(error) {

      return FirestoreResult(value: error);
    }

  }


  Future<DocumentSnapshot> getChat(String driverId) async {
    return await _chatReference.doc(driverId).get();
  }

  CollectionReference get driversReference => _driversReference;

  CollectionReference get usersReference => _usersReference;

  CollectionReference get chatReference => _chatReference;

  DocumentReference getDriverChat(String driverId, String chatId) {
    return driversReference.doc(driverId).collection("chats").doc(chatId);
  }

  DocumentReference getUserChat(String chatId) {
    return driversReference.doc(locator.get<AuthenticationClient>().id).collection("chats").doc(chatId);
  }
}