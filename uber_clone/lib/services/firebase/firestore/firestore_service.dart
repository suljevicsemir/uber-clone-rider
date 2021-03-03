

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';

abstract class FirestoreService {

  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  CollectionReference _userChats = FirebaseFirestore.instance.collection('users').doc(UberAuth.userId).collection('chats');
  CollectionReference _chats = FirebaseFirestore.instance.collection('chats');
  DocumentReference _userSettings = FirebaseFirestore.instance.collection('user_settings').doc(UberAuth.userId);
  DocumentReference _user = FirebaseFirestore.instance.collection('users').doc(UberAuth.userId);





  CollectionReference get users => _users;

  CollectionReference get userChats => _userChats;

  CollectionReference get chats => _chats;

  DocumentReference get userSettings => _userSettings;

  DocumentReference get user => _user;
}