import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/user_data_fields.dart' as globals;


class UserData {

  final String firstName, lastName, phoneNumber, email, providerUserId, firebaseUserId;
  final SignedInType signedInType;
  File profilePicture;
  //UserData({ this.firstName, this.lastName,this.phoneNumber, this.email, this.providerUserId, this.firebaseUserId, this.profilePicture, this.signedInType});


  //reading from SecureStorage and manually gathered data

  UserData.fromMap(Map<String, dynamic> map):
      firstName = map[globals.firstName],
      lastName = map[globals.lastName],
      phoneNumber = '2131', // TODO
      email = map[globals.email],
      providerUserId = map[globals.providerUserId],
      firebaseUserId = map[globals.firebaseUserId],
      signedInType = map[globals.signedInType] == "Google" ? SignedInType.Google : SignedInType.Facebook;


  UserData.fromFirestoreSnapshot(DocumentSnapshot snapshot):
      firstName = snapshot[globals.firstName],
      lastName = snapshot[globals.lastName],
      phoneNumber = snapshot[globals.phoneNumber],
      email = snapshot[globals.email],
      providerUserId = snapshot[globals.providerUserId],
      firebaseUserId = snapshot.id,
      //profilePicture = snapshot[globals.profilePicture],
      signedInType = snapshot[globals.signedInType] == "Google" ? SignedInType.Google : SignedInType.Facebook;





  @override
  String toString() {
    return 'UserData{firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, email: $email, providerUserId: $providerUserId, firebaseId: $firebaseUserId, signedInType: ${signedInType.parseSignedInType()}';
  }



}