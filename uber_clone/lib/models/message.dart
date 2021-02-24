
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Message {
  final String senderId, content, chatId;
  final Timestamp timestamp;

  Message({@required this.senderId, @required this.content, @required this.timestamp, @required this.chatId});
}