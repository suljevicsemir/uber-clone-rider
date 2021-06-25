
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ChatsProvider  {

  String userId = FirebaseAuth.instance.currentUser!.uid;
  Stream<QuerySnapshot> get chats  => FirebaseFirestore.instance.collection('users').doc(userId).collection('chats').orderBy('lastMessageTimestamp', descending: true).snapshots();


}