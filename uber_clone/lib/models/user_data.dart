import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

@immutable
class UserData {
  final String email, displayName, picture;

  UserData.fromFacebookMap(Map<String, dynamic> map) :
      email = map["email"],
      displayName = map["name"],
      picture = "sad";
     // picture = map["picture"].data.url;

  UserData.fromGoogleAccount(GoogleSignInAccount account) :
      email = account.email,
      displayName = account.displayName,
      picture = account.photoUrl;

  UserData.fromFirebaseUser(User user) :
      email = user.email,
      displayName = user.displayName,
      picture = user.photoURL;

  @override
  String toString() {
    return 'UserData{email: $email, displayName: $displayName, picture: $picture}';
  }
}