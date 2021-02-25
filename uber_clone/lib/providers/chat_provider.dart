import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_clone/constants/message.dart' as message_fields;
import 'package:uber_clone/models/message.dart';
class ChatProvider {

  final String userId = FirebaseAuth.instance.currentUser.uid;
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  final CollectionReference _chatReference = FirebaseFirestore.instance.collection('chats');







  Future<void> sendMessage(Message message) async {

    Map<String, dynamic> snapshot = _buildMessage(message);




     await _instance.runTransaction((transaction) async {
       transaction.set(_chatReference.doc(message.chatId).collection('messages').doc(DateTime.now().millisecondsSinceEpoch.toString()), snapshot);
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