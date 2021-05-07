import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber_clone/services/firebase/uber_auth.dart';


class AuthenticationService{

  final UberAuth uberAuth = UberAuth();
  Stream<User?> get authStateChanges => FirebaseAuth.instance.authStateChanges();

  Future<void> signOut() async {
    await uberAuth.signOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<GoogleSignInAccount?> pickAccount() async {
    print('pick account is called');
    return await uberAuth.pickAccount();
  }
}