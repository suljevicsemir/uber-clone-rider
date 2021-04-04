import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/constants/chat_list.dart' as chat_list;
import 'package:uber_clone/constants/message.dart' as message_fields;
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/models/message.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';
class ChatProvider {


  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final CollectionReference _driversReference = FirebaseFirestore.instance.collection('drivers');
  final CollectionReference _usersReference = FirebaseFirestore.instance.collection('users');
  final CollectionReference _chatReference = FirebaseFirestore.instance.collection('chats');

  final Driver driver;
  final UserData userData;
  late String chatId;



  ChatProvider({ required this.driver, required this.userData}) {
    chatId = 'chat' +  (driver.id.compareTo(userData.firebaseUserId) < 0 ?
    (driver.id + userData.firebaseUserId) : (userData.firebaseUserId + driver.id));
  }


  Future<void> sendMessage(Message message) async {

    Map<String, dynamic> snapshot = _buildMessage(message);

     await _instance.runTransaction((transaction) async {
       transaction.set(_chatReference.doc(chatId).collection('messages').doc(DateTime.now().millisecondsSinceEpoch.toString()), snapshot);
     });

    // current user ( rider )
     await _instance.runTransaction((transaction) async {
       transaction.update(_usersReference.doc(userData.firebaseUserId).collection('chats').doc(chatId), {
         chat_list.lastMessage                 : message.message,
         chat_list.lastMessageTimestamp        : message.timestamp,
         chat_list.lastMessageSenderFirebaseId : UberAuth.userId
       });
     });


     await _instance.runTransaction((transaction) async {
       transaction.update(_driversReference.doc(driver.id).collection('chats').doc(chatId), {
         chat_list.lastMessage                 : message.message,
         chat_list.lastMessageTimestamp        : message.timestamp,
         chat_list.lastMessageSenderFirebaseId : UberAuth.userId
       });
     });


  }


  Map<String, dynamic> _buildMessage(Message message) {
    return {
      message_fields.firebaseUserId   : UberAuth.userId,
      message_fields.message          : message.message,
      message_fields.timestamp        : message.timestamp
    };
  }


  Future<void> createChat() async {

    //first we check are the collections already created
    DocumentSnapshot chatHistory = await _chatReference.doc(chatId).get();
    // chat collections are already created, even if there aren't any messages exchanged
    if(chatHistory.exists) {
      return;
    }

    // if not, we need to create three new collections
    _instance.runTransaction((transaction) async {
      transaction.set(_chatReference.doc(chatId), {
        'firebaseUserId1' : UberAuth.userId,
        'firebaseUserId2' : driver.id,
      });
    });




    //chat list of current user (rider)
    _instance.runTransaction((transaction) async {
      transaction.set(_usersReference.doc(userData.firebaseUserId).collection('chats').doc(chatId), {
          chat_list.firebaseUserId              : driver.id,
          chat_list.firstName                   : driver.firstName,
          chat_list.lastName                    : driver.lastName,
          chat_list.lastMessage                 : '',
          chat_list.lastMessageTimestamp        : null,
          chat_list.lastMessageSenderFirebaseId : null,
          chat_list.phoneNumber                 : driver.phoneNumber
      });
    });

    //chat list of driver the user is chatting with (of the driver)
    _instance.runTransaction((transaction) async {
      transaction.set(_driversReference.doc(driver.id).collection('chats').doc(chatId), {
        chat_list.firebaseUserId              : UberAuth.userId,
        chat_list.firstName                   : userData.firstName,
        chat_list.lastName                    : userData.lastName,
        chat_list.lastMessage                 : '',
        chat_list.lastMessageTimestamp        : null,
        chat_list.lastMessageSenderFirebaseId : null,
        chat_list.phoneNumber                 : userData.phoneNumber
      });
    });


  }

  




}