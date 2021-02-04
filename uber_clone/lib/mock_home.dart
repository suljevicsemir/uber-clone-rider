import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class HomeMock extends StatefulWidget {
  @override
  _HomeMockState createState() => _HomeMockState();
}

class _HomeMockState extends State<HomeMock> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FacebookAuth facebookAuth = FacebookAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Mock Home'),
        centerTitle: true,
      ),
      body: Center(



        child: Text('Hello'),
      ),
    );
  }
}
