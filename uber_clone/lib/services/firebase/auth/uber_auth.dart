import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_clone/models/user_data.dart';

abstract class UberAuth {
  static final FirebaseAuth instance = FirebaseAuth.instance;
  static final String? userId = FirebaseAuth.instance.currentUser == null ? '' : FirebaseAuth.instance.currentUser!.uid;

  Future<UserData?> signIn();
  Future<void> signOut();
  Future<bool> isSignedIn();


}