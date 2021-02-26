import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/constants/chat_list.dart' as fields;
@immutable
class ChatInfo {
  final  String chatId,
      lastMessage,
      lastMessageSenderFirebaseId,
      //other participant user id
      firebaseUserId,
      firstName,
      lastName;
  final Timestamp lastMessageTimestamp;

  ChatInfo.fromSnapshot(DocumentSnapshot snapshot) :
      chatId                      = snapshot.id,
      lastMessage                 = snapshot.get(fields.lastMessage),
      lastMessageSenderFirebaseId = snapshot.get(fields.lastMessageSenderFirebaseId),
      lastMessageTimestamp        = snapshot.get(fields.lastMessageTimestamp),
      firebaseUserId              = snapshot[fields.firebaseUserId],
      firstName                   = snapshot[fields.firstName],
      lastName                    = snapshot[fields.lastName];



}