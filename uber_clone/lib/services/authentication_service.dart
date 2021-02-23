import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/globals.dart' as globals;
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/firestore_service.dart';
import 'package:uber_clone/services/secure_storage.dart';

class AuthenticationService{

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  UserData _userData;
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  AuthenticationService(this._firebaseAuth) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    _userData = await SecureStorage.loadUser();
  }
  UserData get currentUserData => _userData;
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




  Future<UserData> signInWithGoogle() async{
    try {
      final GoogleSignInAccount accountUser = await _googleSignIn.signIn();
      if(accountUser != null) {
        final GoogleSignInAuthentication googleAuth = await accountUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken
        );
        await _firebaseAuth.signInWithCredential(credential);
        final payloadMap = _parseToken(googleAuth.idToken);

        final Map<String, dynamic> data = {
          globals.firstName : payloadMap["given_name"],
          globals.lastName : payloadMap["family_name"],
          globals.email : accountUser.email,
          globals.providerUserId : accountUser.id,
          globals.profilePicture : accountUser.photoUrl,
          globals.signedInType : SignedInType.Google.parseSignedInType(),
          globals.firebaseUserId : FirebaseAuth.instance.currentUser.uid
        };

        _userData = UserData.fromMap(data);
        await SecureStorage.saveUser(_userData);
        await FirestoreService.saveUser(_userData);
        return _userData;
      }

      return null;
    } on Exception catch(_) {
      print("Error login with google!");
      return null;
    }
  }

  Future<UserData> signInWithFacebook() async {
    try {
       final AccessToken  accessToken = await FacebookAuth.instance.login();
       final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
       await _firebaseAuth.signInWithCredential(credential);
       String url = 'https://graph.facebook.com/v9.0/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}';
       http.Response x = await http.get(url);
       final profile = json.decode(x.body);
       print(profile);

       final Map<String, dynamic> data = {
         globals.firstName : profile["first_name"],
         globals.lastName : profile["last_name"],
         globals.email : profile["email"],
         globals.providerUserId : profile["id"],
         globals.profilePicture : FirebaseAuth.instance.currentUser.photoURL,
         globals.signedInType : SignedInType.Facebook,
         globals.firebaseUserId : FirebaseAuth.instance.currentUser.uid
       };

       _userData = UserData.fromMap(data);
       await SecureStorage.saveUser(_userData);
       await FirestoreService.saveUser(_userData);
       return _userData;
     } on FacebookAuthException catch(error) {
        print(error.errorCode);
        return null;
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



  Future<bool> isLoggedInWithFacebook() async {
    return (await FacebookAuth.instance.isLogged) != null;
  }
  Future<bool> isLoggedInWithGoogle() async {
    return (await _googleSignIn.isSignedIn());
  }


  Future<void> signOutGoogle() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();



  }

  Future<void> signOutWithFacebook() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();

  }

  GoogleSignIn get googleSignIn => _googleSignIn;
}