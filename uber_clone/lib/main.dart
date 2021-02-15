import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/authentication_wrapper.dart';
import 'package:uber_clone/providers/trips_provider.dart';
import 'package:uber_clone/screens/help/help.dart';
import 'package:uber_clone/screens/home/home.dart';
import 'package:uber_clone/screens/settings/settings.dart';
import 'package:uber_clone/screens/user trips/trips.dart';
import 'package:uber_clone/screens/wallet/wallet.dart';
import 'package:uber_clone/services/authentication_service.dart';
import 'package:uber_clone/theme/theme.dart';

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
        home: AuthenticationWrapper(),
        //za sada neka bude home, treba dodati u auth wrapper
        initialRoute: '/home',
        routes: {
          Home.route : (context) => Home(),
          UserTrips.route : (context) => ChangeNotifierProvider(
              create: (context) => TripsProvider(),
              child: UserTrips()),
          Help.route : (context) => Help(),
          Wallet.route : (context) => Wallet(),
          Settings.route : (context) => Settings()
        },
      ),
    );
  }
}

