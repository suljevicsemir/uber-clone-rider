

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';

class FacebookLoginProgress extends StatefulWidget {

  static const String route = '/facebookLoginProgress';

  @override
  _FacebookLoginProgressState createState() => _FacebookLoginProgressState();
}

class _FacebookLoginProgressState extends State<FacebookLoginProgress> {

  bool abort = false;

  bool instanceLogin = false;


  bool firebaseLogin = false;


  bool facebookGraph = false;

  bool fetchingPicture = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Instance login'),
                  Spacer(),
                  Text(instanceLogin.toString())
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text('Firebase login'),
                  Spacer(),
                  Text(firebaseLogin.toString())
                ],
              ),
              SizedBox(height: 40,),
              Row(
                children: [
                  Text('Facebook graph request'),
                  Spacer(),
                  Text(facebookGraph.toString())
                ],
              ),
              SizedBox(height: 40,),
              Row(
                children: [
                  Text('Fetching picture'),
                  Spacer(),
                  Text(fetchingPicture.toString())
                ],
              ),

              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  LoginResult? loginResult = await FacebookAuth.instance.login();
                  //print(loginResult.status.toString());
                  //print(loginResult.accessToken);

                  if(loginResult != null) {
                    setState(() {
                      instanceLogin = true;
                    });
                  }
                  final AuthCredential credential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
                  print(credential.token);
                  UserCredential uc = await UberAuth.instance.signInWithCredential(credential);
                  setState(() {
                    firebaseLogin = true;
                  });
                  String url = 'https://graph.facebook.com/v9.0/me?fields=name,picture.width(1200).height(800),first_name,last_name,email&access_token=${loginResult.accessToken!.token}';
                  Uri uri = Uri.parse(url);

                  //Facebook profile picture must be downloaded from the facebook API
                  http.Response x = await http.get(uri);

                  final profile = json.decode(x.body);

                  if( profile != null)
                    setState(() {
                      facebookGraph = true;
                    });

                  var pictureData = profile["picture"];
                  var picture = pictureData["data"];

                  var photoUrl = picture["url"];

                  Uri sljedeci = Uri.parse(photoUrl);
                  http.Response respon = await http.get(sljedeci);

                  if(respon.bodyBytes.isNotEmpty) {
                    setState(() {
                      fetchingPicture = true;
                    });
                  }




                },
                child: Text('Login with facebook')
              )
            ],
          ),
        ),
      ),
    );
  }
}
