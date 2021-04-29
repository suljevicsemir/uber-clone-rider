import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber_clone/services/firebase/auth/google_auth.dart';

class AuthenticationService{

  final GoogleAuth googleAuth = GoogleAuth();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => FirebaseAuth.instance.authStateChanges();

  Future<void> signOut() async {
    //await googleAuth.signOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<GoogleSignInAccount?> pickAccount() async {
    print('pick account is called');
    return await googleSignIn.signIn();
  }
}