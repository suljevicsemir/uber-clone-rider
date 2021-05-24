import 'package:google_sign_in/google_sign_in.dart';

class UberAuth {

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount?> pickAccount() async {
    return await googleSignIn.signIn();
  }

  Future<bool> isSignedIn() async {
    return (await googleSignIn.isSignedIn());
  }
  Future<void> signOut() async{
    await googleSignIn.signOut();
  }






}