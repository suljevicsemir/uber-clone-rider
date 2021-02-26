
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/constants/message.dart' as fields;
@immutable
class Message {


  // might need some additional fields for notifications implementation
  final String message, firebaseUserId;
  final Timestamp timestamp;

  Message({
    @required this.message,
    @required this.timestamp,
    this.firebaseUserId
  });


  Message.fromSnapshot(DocumentSnapshot snapshot) :
      message = snapshot.get(fields.message),
      timestamp = snapshot.get(fields.timestamp),
      firebaseUserId = snapshot.get(fields.firebaseUserId);


}