
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber_clone/constants/user_fields.dart' as user_fields;
import 'package:uber_clone/models/signed_in_type.dart';

part 'authentication_client.g.dart';

class AuthenticationClient {

  final FirebaseAuth _instance = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // is only used when the user is logged in
  static String get id => FirebaseAuth.instance.currentUser!.uid;

  

  Future<void> nes() async{

    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();

      if( account == null) {
        return;
      }
      final GoogleSignInAuthentication googleAuth = await account.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );






    }
    on Exception catch(err) {

    }


  }




}