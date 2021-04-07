
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/cached_data/temp_directory_service.dart';
import 'package:uber_clone/services/firebase/auth/facebook_login.dart';
import 'package:uber_clone/services/firebase/auth/google_auth.dart';
import 'package:uber_clone/services/firebase/ride_verification_service.dart';
import 'package:uber_clone/services/firebase/storage/storage_provider.dart';
import 'package:uber_clone/services/user_data_service.dart';
class AuthenticationService{


  final GoogleAuth googleAuth = GoogleAuth();
  final FacebookLogin facebookLogin = FacebookLogin();
  final UserDataService userDataService = UserDataService();
  final UserSettingsService settingsService = UserSettingsService();

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => FirebaseAuth.instance.authStateChanges();


  Future<void> signOut() async {
    await googleAuth.signOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<GoogleSignInAccount?> pickAccount() async {
    print('pick account is called');
    return await googleSignIn.signIn();
  }


  /*Future<UserData?> signInWithFacebook() async {
    UserData? userData = await facebookLogin.signIn();
    if(userData == null)
      return null;

    await userDataService.saveUserData(userData);
    await settingsService.saveRideVerification();
    FacebookPermissions x;

    Uri uri = Uri.parse(userData.profilePicture!);



    http.Response response = await http.get(uri);
    print('DOHVACENA SLIKA PROFILA');

    File? picture = await TempDirectoryService.storeUserPicture(response.bodyBytes);
    print('SPASENA LOKALNO');

    await FirebaseStorageProvider.uploadPictureFromFile(picture!);
    print('SPASENA U STORAGE');

    return userData;
  }*/

  Future<UserData?> signInWithGoogle() async {

    UserData? userData = await googleAuth.signIn();
    if(userData == null)
      return null;

    await userDataService.saveUserData(userData);
    await settingsService.saveRideVerification();


    Uri uri = Uri.parse(userData.profilePicture!);

    http.Response response = await http.get(uri);

    await TempDirectoryService.storeUserPicture(response.bodyBytes);
    await FirebaseStorageProvider.uploadPictureFromList(response.bodyBytes);

    return userData;
  }

}