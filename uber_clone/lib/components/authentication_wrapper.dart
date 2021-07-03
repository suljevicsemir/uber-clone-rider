import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/getx_controllers/user_data.dart';
import 'package:uber_clone/providers/home_provider.dart';
import 'package:uber_clone/screens/get_started/get_started.dart';
import 'package:uber_clone/screens/home/home.dart';

class AuthenticationWrapper extends StatelessWidget {

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);


    final UserDataController userDataController = Get.put(UserDataController());


    return user != null ?
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => HomeProvider(),
            lazy: false,
          ),
        ],
        child: Home()) : GetStarted();

  }
}

