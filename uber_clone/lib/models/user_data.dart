import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/user_data_fields.dart' as globals;

@immutable
class UserData {

  final String firstName, lastName, profilePictureUrl, email, providerUserId, firebaseUserId;
  final SignedInType signedInType;


  //reading from SecureStorage and manually gathered data

  UserData.fromLocalStorage(Map<String, dynamic> map):
      firstName = map[globals.firstName],
      lastName = map[globals.lastName],
      email = map[globals.email],
      providerUserId = map[globals.providerUserId],
      firebaseUserId = map[globals.firebaseUserId],
      profilePictureUrl = map[globals.profilePicture],
      signedInType = map[globals.signedInType] == "Google" ? SignedInType.Google : SignedInType.Facebook;





  UserData.fromFirestoreSnapshot(DocumentSnapshot snapshot):
      firstName = snapshot[globals.firstName],
      lastName = snapshot[globals.lastName],
      email = snapshot[globals.email],
      providerUserId = snapshot[globals.providerUserId],
      firebaseUserId = snapshot.id,
      profilePictureUrl = snapshot[globals.profilePicture],
      signedInType = snapshot[globals.signedInType] == "Google" ? SignedInType.Google : SignedInType.Facebook;





  @override
  String toString() {
    return 'UserData{firstName: $firstName, lastName: $lastName, email: $email, providerUserId: $providerUserId, firebaseId: $firebaseUserId, signedInType: ${signedInType.parseSignedInType()}';
  }



}