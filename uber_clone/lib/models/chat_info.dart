import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/constants/chat_info_fields.dart' as fields;
@immutable
class ChatInfo {
  final String chatId,
      driverId,
      firstName,
      lastName,
      lastMessage,
      lastMessageSenderFirebaseId;
  final Timestamp lastMessageTimestamp;

  ChatInfo.fromSnapshot(DocumentSnapshot snapshot) :
      chatId                      = snapshot.id,
      firstName                   = snapshot[fields.firstName],
      lastName                    = snapshot[fields.lastName],
      lastMessage                 = snapshot[fields.lastMessage],
      lastMessageSenderFirebaseId = snapshot[fields.lastMessageSenderFirebaseId],
      lastMessageTimestamp        = snapshot[fields.lastMessageTimestamp],
      driverId                    = snapshot[fields.driverId];




}