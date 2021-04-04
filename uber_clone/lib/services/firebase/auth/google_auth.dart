import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';
import 'package:uber_clone/user_data_fields.dart' as user_data_fields;

class GoogleAuth extends UberAuth {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Future<bool> isSignedIn() async{
    return (await googleSignIn.isSignedIn());
  }

  @override
  Future<UserData?> signIn() async{
    try {
      GoogleSignInAccount? accountUser = await googleSignIn.signIn();

      if( accountUser == null)
        return null;

      final GoogleSignInAuthentication googleAuth = await accountUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      await UberAuth.instance.signInWithCredential(credential);

      final Map<String, dynamic> payloadMap = _parseGoogleToken(googleAuth.idToken!)!;
      Map<String, dynamic> createUserData = _userData(payloadMap, accountUser);

      return UserData.fromMap(createUserData);
    }
    on Exception catch(_) {
      print("Error login with google!");
      return null;
    }
  }

  @override
  Future<void> signOut() async{
    await googleSignIn.signOut();
  }

  Map<String, dynamic>? _parseGoogleToken(String? token) {
    if( token == null)
      return null;

    final List<String> tokenParts = token.split('.');
    if(tokenParts.length != 3)
      return null;

    final String tokenPayload = tokenParts[1];
    final String normalized = base64Url.normalize(tokenPayload);
    final String response = utf8.decode(base64Url.decode(normalized));

    final payloadMap = json.decode(response);
    if( payloadMap is! Map<String, dynamic>)
      return null;

    return payloadMap;
  }
  Map<String, dynamic> _userData(Map<String,dynamic> payloadMap, GoogleSignInAccount account) {
    return {
      user_data_fields.firstName : payloadMap["given_name"],
      user_data_fields.lastName  : payloadMap["family_name"],
      user_data_fields.email     : account.email,
      user_data_fields.providerUserId : account.id,
      user_data_fields.profilePicture : account.photoUrl,
      user_data_fields.signedInType : SignedInType.Google.parseSignedInType(),
      user_data_fields.firebaseUserId : UberAuth.userId,
      user_data_fields.phoneNumber : 'THIS IS A MOCK PHONE NUMBER'
    };
  }

}