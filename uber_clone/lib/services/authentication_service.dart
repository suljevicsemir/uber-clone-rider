import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/models/user_data.dart';

enum SignedInType {
  Google,
  Facebook
}


class AuthenticationService {

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth facebookAuth = FacebookAuth.instance;

  SignedInType signedInType;
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  AuthenticationService(this._firebaseAuth);

  User get currentUser => _firebaseAuth.currentUser;



   _parseToken(String token ) {
    if(token == null) return null;
    final List<String> parts = token.split('.');
    if(parts.length != 3) return null;

    final String payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));

    final payloadMap = json.decode(resp);
    if( payloadMap is! Map<String, dynamic>) {
      return null;
    }

    final String firstName = payloadMap["given_name"];
    final String lastName = payloadMap["family_name"];

    print("First name: " + firstName);
    print("Last name: " + lastName);
    return payloadMap;


  }







  Future<bool> signInWithGoogle() async{
    try {
      final GoogleSignInAccount accountUser = await _googleSignIn.signIn();
      if(accountUser != null) {
        final GoogleSignInAuthentication googleAuth = await accountUser.authentication;
        final idToken = googleAuth.idToken;
        print("Ovo je access token");
        _parseToken(idToken);
        print( googleAuth.accessToken.toString());
        print("Ovo je auth id token");
        print(idToken.toString());
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken
        );
        await _firebaseAuth.signInWithCredential(credential);
        return true;
      }
      return false;
    } on Exception catch(_) {
      print("Error login with google!");
      return false;
    }
  }

  Future<bool> signInWithFacebook() async {

    try {
       final AccessToken accessToken = await FacebookAuth.instance.login();
       final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
       await _firebaseAuth.signInWithCredential(credential);
       print('Access token id');
       print(accessToken.userId);
       String url = 'https://graph.facebook.com/v9.0/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}';
       http.Response x = await http.get(url);
       final profile = json.decode(x.body);
       print(profile);
       final Map<String, dynamic> facebookUserData = await FacebookAuth.instance.getUserData();
       print("Firebase Auth id");
       print(_firebaseAuth.currentUser.uid);

       return true;
     } on FacebookAuthException catch(error) {
        print(error.errorCode);
        return false;
     }

  }


  Future<String> signInWithEmail(String email, String password)  async{
  await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return "Signed in";
  }

  Future<String> signUpWithEmail(String email, String password) async {
  await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  return "Created";
  }

  UserData getUserData()  {
    return UserData.fromFirebaseUser(FirebaseAuth.instance.currentUser);
  }


  Future<bool> isLoggedInWithFacebook() async {
    return (await FacebookAuth.instance.isLogged) != null;
  }
  Future<bool> isLoggedInWithGoogle() async {
    return (await _googleSignIn.isSignedIn());
  }


  Future<void> signOutGoogle() async {

    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();

  }

  Future<void> signOutWithFacebook() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
  }

  GoogleSignIn get googleSignIn => _googleSignIn;
}