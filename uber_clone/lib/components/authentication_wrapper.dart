import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/screens/get_started/get_started.dart';
import 'package:uber_clone/screens/home/home.dart';


class AuthenticationWrapper extends StatelessWidget {

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    return user != null ? Home() : GetStarted();

  }
}

