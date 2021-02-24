import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/constants/chat_info_fields.dart' as fields;
@immutable
class ChatInfo {
  final String chatId, firstName, lastName, lastMessage, senderFirebaseId;
  final Timestamp lastMessageTimestamp;

  ChatInfo.fromSnapshot(DocumentSnapshot snapshot) :
      chatId               = snapshot[fields.chatId],
      firstName            = snapshot[fields.firstName],
      lastName             = snapshot[fields.lastName],
      lastMessage          = snapshot[fields.lastMessage],
      senderFirebaseId     = snapshot[fields.senderFirebaseId],
      lastMessageTimestamp = snapshot[fields.lastMessageTimestamp];




}