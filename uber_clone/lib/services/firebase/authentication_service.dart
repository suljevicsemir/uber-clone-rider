import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/firebase/auth/facebook_login.dart';
import 'package:uber_clone/services/firebase/auth/google_auth.dart';
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';
import 'package:uber_clone/services/user_data_service.dart';

class AuthenticationService{


  final GoogleAuth googleAuth = GoogleAuth();
  final FacebookLogin facebookLogin = FacebookLogin();
  final UserDataService userDataService = UserDataService();

  final FacebookAuth facebookAuth = FacebookAuth.instance;
  UserData _userData;

  Stream<User> get authStateChanges => UberAuth.instance.authStateChanges();


  AuthenticationService() {
    if(UberAuth.instance.currentUser != null) {
      _loadUser();
    }
  }

  Future<void> _loadUser() async {
    _userData = await userDataService.loadUser();
  }


  Future<void> signOut() async {
    if( await facebookLogin.isSignedIn()) {
      await facebookLogin.signOut();
    }
    else {
      await googleAuth.signOut();
    }
    await UberAuth.instance.signOut();
  }

  Future<UserData> signInWithFacebook() async {
    _userData = await facebookLogin.signIn();
    return _userData;
  }

  Future<UserData> signInWithGoogle() async {
    _userData = await googleAuth.signIn();
    return _userData;
  }

  UserData get userData => _userData;
}