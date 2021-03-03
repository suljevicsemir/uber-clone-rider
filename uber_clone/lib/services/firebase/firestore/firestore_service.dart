

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';

abstract class FirestoreService {

  static CollectionReference users = FirebaseFirestore.instance.collection('users');
  static CollectionReference userChats = FirebaseFirestore.instance.collection('users').doc(UberAuth.userId).collection('chats');
  static CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  static DocumentReference userSettings = FirebaseFirestore.instance.collection('user_settings').doc(UberAuth.userId);
  static DocumentReference user = FirebaseFirestore.instance.collection('users').doc(UberAuth.userId);



}