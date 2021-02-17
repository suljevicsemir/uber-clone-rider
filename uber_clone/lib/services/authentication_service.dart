import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber_clone/models/user_data.dart';

enum SignedInType {
  Google,
  Facebook
}


class AuthenticationService{

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth facebookAuth = FacebookAuth.instance;

  SignedInType signedInType;
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  AuthenticationService(this._firebaseAuth);

  User get currentUser => _firebaseAuth.currentUser;

  Future<bool> signInWithGoogle() async{
    try {
      final GoogleSignInAccount accountUser = await _googleSignIn.signIn();
      if(accountUser != null) {
        final GoogleSignInAuthentication googleAuth = await accountUser.authentication;
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
       final  accessToken = await FacebookAuth.instance.login();
       final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
       await _firebaseAuth.signInWithCredential(credential);
       final Map<String, dynamic> facebookUserData = await FacebookAuth.instance.getUserData();

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
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();



  }

  Future<void> signOutWithFacebook() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();

  }

  GoogleSignIn get googleSignIn => _googleSignIn;
}