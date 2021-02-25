
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Message {

  // chatId is only in this class, not in the Firestore, it's not necessary
  // might need some additional fields for notifications implementation
  final String senderFirebaseId, content, chatId;
  final Timestamp timestamp;

  Message({
    @required this.senderFirebaseId,
    @required this.content,
    @required this.timestamp,
    @required this.chatId
  });
}