
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Message {


  // might need some additional fields for notifications implementation
  final String content;
  final Timestamp timestamp;

  Message({
    @required this.content,
    @required this.timestamp,
  });
}