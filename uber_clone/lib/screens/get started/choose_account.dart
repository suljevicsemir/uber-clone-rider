
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/authentication_wrapper.dart';
import 'package:uber_clone/services/authentication_service.dart';

class ChooseAccount extends StatefulWidget {
  @override
  _ChooseAccountState createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              Container(
                margin: EdgeInsets.only(left: 10, top: MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Choose an account'),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Material(
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () async {
                          final bool result = await Provider.of<AuthenticationService>(context, listen: false).signInWithFacebook();
                          if(result) {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationWrapper()), (_) => false);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.facebookSquare, color: const Color(0xff4267B2),),
                              SizedBox(width: 0.05 * MediaQuery.of(context).size.width,),
                              Text('Facebook')
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Material(
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: ()  async{
                          final bool result = await Provider.of<AuthenticationService>(context, listen: false).signInWithGoogle();
                          if(result) {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationWrapper()), (_) => false);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.google, color: Colors.blue,),
                              SizedBox(width: 0.05 * MediaQuery.of(context).size.width,),
                              Text('Google')
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text('By clicking on a social option you may receive an SMS for verification. Message and data rates may apply'),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
