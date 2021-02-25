
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_clone/constants/message.dart' as message_fields;
import 'package:uber_clone/models/message.dart';
class ChatsProvider  {

  String userId = FirebaseAuth.instance.currentUser.uid;
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final CollectionReference _chatReference = FirebaseFirestore.instance.collection('chats');
  Stream<QuerySnapshot> get chats  => FirebaseFirestore.instance.collection('users').doc(userId).collection('chats').snapshots();

  Stream<QuerySnapshot> getChat(String userId) {
    String chatId = 'chat' + (this.userId.compareTo(userId) < 0 ? this.userId : userId);
    return FirebaseFirestore.instance.collection('chats').doc(chatId).collection('messages').snapshots();
  }

  Future<void> sendMessage(Message message) async {
    Timestamp timestamp = Timestamp.now();

    await _instance.runTransaction((transaction)  async {
      transaction.set(_chatReference.doc(message.chatId).collection('messages').doc(DateTime.now().millisecondsSinceEpoch.toString()), _buildMessage(message)

      );
    });
  }


  Map<String, dynamic> _buildMessage(Message message) {
    return {
      message_fields.senderFirebaseId  : message.senderFirebaseId,
      message_fields.content   : message.content,
      message_fields.timestamp : message.timestamp
    };
  }








}