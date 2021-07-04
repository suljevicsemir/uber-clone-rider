
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/constants/message.dart' as fields;
@immutable
class Message {



  final String message;
  final String firebaseUserId;
  final String driverId;
  final String chatId;
  final Timestamp timestamp;

  Message({
    required this.message,
    required this.timestamp,
    required this.firebaseUserId,
    required this.driverId,
    required this.chatId
  });


  Message.fromSnapshot(DocumentSnapshot snapshot) :
      message        = snapshot.get(fields.message),
      timestamp      = snapshot.get(fields.timestamp),
      firebaseUserId = snapshot.get(fields.firebaseUserId),
      driverId       = snapshot.get(fields.driverId),
      chatId         = snapshot.get(fields.chatId);


  Map<String, dynamic> toJson() => {
    fields.message        : this.message,
    fields.timestamp      : this.timestamp,
    fields.firebaseUserId : this.firebaseUserId,
    fields.driverId       : this.driverId,
    fields.chatId         : this.chatId
  };


}