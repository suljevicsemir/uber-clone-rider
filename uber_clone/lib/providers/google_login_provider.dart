
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/models/google_sign_result.dart';
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/cached_data/temp_directory_service.dart';
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';
import 'package:uber_clone/services/firebase/ride_verification_service.dart';
import 'package:uber_clone/services/firebase/storage/storage_provider.dart';
import 'package:uber_clone/services/user_data_service.dart';
import 'package:uber_clone/user_data_fields.dart' as user_data_fields;

class GoogleLoginProvider extends ChangeNotifier{

  GoogleSignInProgress progress = GoogleSignInProgress();

  final UserDataService userDataService = UserDataService();
  final UserSettingsService settingsService = UserSettingsService();
  final GoogleSignInAccount account;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  UserData? userData;

  GoogleLoginProvider({required this.account}) {
    signInWithGoogle();
  }

  Future<void> _signOut() async {

    await googleSignIn.signOut();
    if(FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  Future<UserData?> signIn() async{
    try {
      final GoogleSignInAuthentication googleAuth = await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );
      progress.accountAuthentication = true;
      notifyListeners();

      await UberAuth.instance.signInWithCredential(credential);

      progress.uberSignIn = true;
      notifyListeners();

      final Map<String, dynamic> payloadMap = _parseGoogleToken(googleAuth.idToken!)!;
      Map<String, dynamic> createUserData = _userData(payloadMap, account);
      userData = UserData.fromMap(createUserData);
      return userData;
    }
    on Exception catch(_) {
      print("Error login with google!");

      return null;
    }
  }

  Future<UserData?> signInWithGoogle() async {
    try {
      UserData? userData = await signIn().timeout(const Duration(seconds: 3));
      if(userData == null)
        return null;
      print(userData.toString());
      await userDataService.saveUserData(userData);
      progress.savingData = true;
      notifyListeners();

      Uri uri = Uri.parse(userData.profilePicture!);
      http.Response response = await http.get(uri);

      File? picture = await TempDirectoryService.storeUserPicture(response.bodyBytes);


      await FirebaseStorageProvider.uploadPictureFromFile(picture!);
      progress.storingPicture = true;
      progress.result = GoogleSignInResult.Success;
      notifyListeners();
      return userData;
    }
    on TimeoutException catch(err) {
      progress.result = GoogleSignInResult.Cancelled;
      await _signOut();
      notifyListeners();
      return null;
    }
    catch (err) {
      progress.result = GoogleSignInResult.Cancelled;
      await _signOut();
      notifyListeners();

      return null;
    }
  }


  Map<String, dynamic>? _parseGoogleToken(String? token) {
    if( token == null)
      return null;

    final List<String> tokenParts = token.split('.');
    if(tokenParts.length != 3)
      return null;

    final String tokenPayload = tokenParts[1];
    final String normalized = base64Url.normalize(tokenPayload);
    final String response = utf8.decode(base64Url.decode(normalized));

    final payloadMap = json.decode(response);
    if( payloadMap is! Map<String, dynamic>)
      return null;

    return payloadMap;
  }


  Map<String, dynamic> _userData(Map<String,dynamic> payloadMap, GoogleSignInAccount account) {
    return {
      user_data_fields.firstName : payloadMap["given_name"],
      user_data_fields.lastName  : payloadMap["family_name"],
      user_data_fields.email     : account.email,
      user_data_fields.providerUserId : account.id,
      user_data_fields.profilePicture : account.photoUrl,
      user_data_fields.signedInType : SignedInType.Google.parseSignedInType(),
      user_data_fields.firebaseUserId : FirebaseAuth.instance.currentUser!.uid,
      user_data_fields.phoneNumber : 'THIS IS A MOCK PHONE NUMBER'
    };
  }



}




enum GoogleLoginProgress {
  SigningInGoogle,
  AccountAuthentication,
  SigningInUber,
  SavingUserData,
  SavingRideSettings,
  FetchingProfilePicture,
  CachingProfilePicture,
  UploadingProfilePicture,
  Success,
  Cancelled
}