import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/authentication_wrapper.dart';
import 'package:uber_clone/providers/trips_provider.dart';
import 'package:uber_clone/screens/driver_contact/driver_contact.dart';
import 'package:uber_clone/screens/get%20started/choose_account.dart';
import 'package:uber_clone/screens/get%20started/choose_login_type.dart';
import 'package:uber_clone/screens/get%20started/get_started.dart';
import 'package:uber_clone/screens/help/help.dart';
import 'package:uber_clone/screens/home/home.dart';
import 'package:uber_clone/screens/edit_account/edit_account.dart';
import 'package:uber_clone/screens/user trips/trips.dart';
import 'package:uber_clone/screens/wallet/wallet.dart';
import 'package:uber_clone/services/authentication_service.dart';
import 'package:uber_clone/theme/theme.dart';
import 'package:uber_clone/screens/account_settings/account_settings.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (context) => AuthenticationService((FirebaseAuth.instance)),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme(),
        initialRoute: '/',
        routes: {
          AuthenticationWrapper.route : (context) => AuthenticationWrapper(),
          GetStarted.route : (context) => GetStarted(),
          LoginTypePicker.route : (context ) => LoginTypePicker(),
          ChooseAccount.route : (context) => ChooseAccount(),
          Home.route : (context) => Home(),
          UserTrips.route : (context) => ChangeNotifierProvider(
              create: (context) => TripsProvider(),
              child: UserTrips()),
          Help.route : (context) => Help(),
          Wallet.route : (context) => Wallet(),
          EditAccount.route : (context) => EditAccount(),
          DriverContact.route: (context) => DriverContact(),
          AccountSettings.route : (context) => AccountSettings()
        },
      ),
    );
  }
}

