import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';
import 'package:uber_clone/user_data_fields.dart' as user_data_fields;

class FacebookLogin extends UberAuth {

  final FacebookAuth facebookAuth = FacebookAuth.instance;

  @override
  Future<bool> isSignedIn() async {
    return (await facebookAuth.isLogged) != null;
  }

  @override
  Future<UserData> signIn() async {
    try {
      final AccessToken  accessToken = await FacebookAuth.instance.login();
      final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
      await UberAuth.instance.signInWithCredential(credential);
      String url = 'https://graph.facebook.com/v9.0/me?fields=name,picture.width(400).height(400),first_name,last_name,email&access_token=${accessToken.token}';

      //Facebook profile picture must be downloaded from the facebook API
      http.Response x = await http.get(url);

      final profile = json.decode(x.body);
      var pictureData = profile["picture"];
      var picture = pictureData["data"];
      print(picture["url"]);
      final Map<String, dynamic> data = {
        user_data_fields.firstName : profile["first_name"],
        user_data_fields.lastName : profile["last_name"],
        user_data_fields.email : profile["email"],
        user_data_fields.providerUserId : profile["id"],
        user_data_fields.profilePicture : picture["url"],
        user_data_fields.signedInType : SignedInType.Facebook.parseSignedInType(),
        user_data_fields.firebaseUserId : UberAuth.userId,
        user_data_fields.phoneNumber : 'THIS IS A MOCK PHONE NUMBER',

      };

      return UserData.fromMap(data);
    } on FacebookAuthException catch(error) {
      print('GRESKA PRI SIGN IN');
      print(error.errorCode);
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await facebookAuth.logOut();
  }

}