import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/services/authentication_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Center(
                  child: Text('This is home')
              ),
              GestureDetector(
                onTap: () async{
                  await Provider.of<AuthenticationService>(context, listen: false).signOutGoogle();
                },
                child: Text('Sign out with google'),
              ),
              GestureDetector(
                onTap: () async {
                  await Provider.of<AuthenticationService>(context, listen: false).signOutWithFacebook();
                },
                child: Text('Sign out with facebook'),
              ),
              GestureDetector(
                onTap: () {
                  print(Provider.of<AuthenticationService>(context, listen: false).getUserData());
                },
                child: Text("PRINT USER DATA TO CONSOLE"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
