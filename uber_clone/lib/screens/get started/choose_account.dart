import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/authentication_wrapper.dart';
import 'package:uber_clone/models/user_data.dart';

import 'file:///C:/Users/semir/FlutterProjects/uber-clone/uber_clone/lib/services/firebase/authentication_service.dart';

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
                            final UserData result = await Provider.of<AuthenticationService>(context, listen: false).signInWithFacebook();
                            if(result != null) {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationWrapper()), (_) => false);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              children: [
                                Image.asset('assets/images/facebook_icon.png', scale: 16,),
                                SizedBox(width: 20),
                                Text('Facebook', style: TextStyle(fontSize: 18),)
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
                            final UserData result = await Provider.of<AuthenticationService>(context, listen: false).signInWithGoogle();
                            if( result != null) {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationWrapper()), (_) => false);
                            }
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
