import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_clone/constants/chat_list.dart' as fields;
import 'package:uber_clone/services/driver_search_delegate.dart';

class ChatInfo {
    String chatId,
      lastMessage,
      lastMessageSenderFirebaseId,
      //other participant user id
      firebaseUserId,
      firstName,
      lastName;
   Timestamp lastMessageTimestamp;

  ChatInfo.fromSnapshot(DocumentSnapshot snapshot) :
      chatId                      = snapshot.id,
      lastMessage                 = snapshot.get(fields.lastMessage),
      lastMessageSenderFirebaseId = snapshot.get(fields.lastMessageSenderFirebaseId),
      lastMessageTimestamp        = snapshot.get(fields.lastMessageTimestamp),
      firebaseUserId              = snapshot[fields.firebaseUserId],
      firstName                   = snapshot[fields.firstName],
      lastName                    = snapshot[fields.lastName];

    ChatInfo.fromDriver(MockDriver driver)  {
      firstName = driver.firstName;
      lastName = driver.lastName;
      firebaseUserId = driver.id;
      chatId = 'chat' +  (FirebaseAuth.instance.currentUser.uid.compareTo(driver.id) < 0 ?
      (FirebaseAuth.instance.currentUser.uid + driver.id) : (driver.id + FirebaseAuth.instance.currentUser.uid));
    }
}