

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/authentication_wrapper.dart';
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/providers/chat_provider.dart';
import 'package:uber_clone/providers/driver_profile_provider.dart';
import 'package:uber_clone/providers/google_login_provider.dart';
import 'package:uber_clone/providers/settings/ride_verification.dart';
import 'package:uber_clone/providers/trips_provider.dart';
import 'package:uber_clone/screens/account_settings/ride_verification/ride_verification.dart';
import 'package:uber_clone/screens/export.dart';
import 'package:uber_clone/screens/facebook_login/facebook_login.dart';
import 'package:uber_clone/screens/get_started/choose_account.dart';
import 'package:uber_clone/screens/get_started/choose_login_type.dart';
import 'package:uber_clone/screens/google_login/google_login.dart';

class UberRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {

      case AccountSettings.route:
        return MaterialPageRoute(
          builder: (_) => AccountSettings()
        );
      case Chat.route:
        Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => Provider(
              create: (context) => ChatProvider(driver: map['driver'], userData: map['user']),
              child: Chat(driver: map['driver'] as Driver)
          )
        );

      case Chats.route:
        return MaterialPageRoute(
          builder: (_) => Chats()
        );

      case DriverContact.route:
        return MaterialPageRoute(
          builder: (_) => DriverContact(driver: settings.arguments as Driver,)
        );

      case DriverProfile.route:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
              create: (context) => DriverProfileProvider(id: settings.arguments as String),
              lazy: false,
              child: DriverProfile()
          )
        );

      case EditAccount.route:
        return MaterialPageRoute(
          builder: (_) => EditAccount()
        );

      case GetStarted.route:
        return MaterialPageRoute(
          builder: (_) => GetStarted()
        );

      case LoginTypePicker.route:
        return MaterialPageRoute(
          builder: (_) => LoginTypePicker()
        );

      case ChooseAccount.route:
        return MaterialPageRoute(
          builder: (_) => ChooseAccount()
        );

      case Help.route:
        return MaterialPageRoute(
          builder: (_) => Help()
        );

      case UserTrips.route:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
              create: (context) => TripsProvider(),
              child: UserTrips()
          )
        );

      case Wallet.route:
        return MaterialPageRoute(
          builder: (_) => Wallet()
        );


      case Home.route:
        return MaterialPageRoute(
          builder: (_) => Home()
        );

      case RideVerification.route:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => RideVerificationProvider(),
            child: RideVerification(),
          )
        );

      case FacebookLoginProgress.route:
        return MaterialPageRoute(
          builder: (_) => FacebookLoginProgress()
        );

      case GoogleLogin.route:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
              lazy: false,
              create: (context) => GoogleLoginProvider( account: settings.arguments as GoogleSignInAccount),
              child: GoogleLogin()
          )
        );

        default:
        return MaterialPageRoute(
          builder: (_) => AuthenticationWrapper()
        );

    }
  }
}