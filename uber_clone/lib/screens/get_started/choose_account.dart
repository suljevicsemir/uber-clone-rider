import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/screens/google_login/google_login.dart';
import 'package:uber_clone/services/firebase/authentication_service.dart';
class ChooseAccount extends StatelessWidget {

  static const String route = '/chooseAccount';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(child: Text('Choose an account', style: TextStyle(fontSize: 22),)),
                      SizedBox(height: 30),
                      Material(
                        child: InkWell(
                          splashColor: Colors.grey,
                          onTap: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.yellowAccent,
                                content: Row(
                                  children: [
                                    Icon(Icons.browser_not_supported),
                                    Text('Facebook login is no longer supported', style: TextStyle(color: Colors.black),)
                                  ],
                                ),
                              )
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              children: [
                                Image.asset('assets/images/facebook_icon.png', scale: 16,),
                                SizedBox(width: 20),
                                Text('Facebook', style: TextStyle(fontSize: 18),),
                                Spacer(),
                                Text('So long partner :(')
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Material(
                        child: InkWell(
                          splashColor: Colors.grey,
                          onTap: ()  async{
                            Timer(const Duration(milliseconds: 200), () async {
                              GoogleSignInAccount? account = await Provider.of<AuthenticationService>(context, listen: false).pickAccount();
                              if( account != null) {
                                await Navigator.pushNamed(context, GoogleLogin.route, arguments: account);
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              children: [
                                Image.asset('assets/images/google_icon.png', scale: 16,),
                                SizedBox(width: 20),
                                Text('Google', style: TextStyle(fontSize: 18))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text('By clicking on a social option you may receive an SMS for verification. Message and data rates may apply', style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
