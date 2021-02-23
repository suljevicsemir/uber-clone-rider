import 'package:flutter/cupertino.dart';
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/user_data_fields.dart' as globals;

@immutable
class UserData {

  final String firstName, lastName, phoneNumber, email, providerUserId, firebaseUserId, profilePicture;
  final SignedInType signedInType;

  UserData({ this.firstName, this.lastName,this.phoneNumber, this.email, this.providerUserId, this.firebaseUserId, this.profilePicture, this.signedInType});


  UserData.fromMap(Map<String, dynamic> map):
      firstName = map[globals.firstName],
      lastName = map[globals.lastName],
      phoneNumber = '2131', // TODO
      email = map[globals.email],
      providerUserId = map[globals.providerUserId],
      firebaseUserId = map[globals.firebaseUserId],
      profilePicture = map[globals.profilePicture],
      signedInType = map[globals.signedInType] == "Google" ? SignedInType.Google : SignedInType.Facebook;


  @override
  String toString() {
    return 'UserData{firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, email: $email, providerUserId: $providerUserId, firebaseId: $firebaseUserId, profilePicture: $profilePicture, signedInType: ${signedInType.parseSignedInType()}';
  }



}