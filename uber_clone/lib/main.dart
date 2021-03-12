import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/authentication_wrapper.dart';
import 'package:uber_clone/providers/cached_data_provider.dart';
import 'package:uber_clone/providers/settings/ride_verification.dart';
import 'package:uber_clone/providers/trips_provider.dart';
import 'package:uber_clone/providers/user_data_provider.dart';
import 'package:uber_clone/screens/account_settings/account_settings.dart';
import 'package:uber_clone/screens/account_settings/ride_verification/ride_verification.dart';
import 'package:uber_clone/screens/chat/chat.dart';
import 'package:uber_clone/screens/chats/chats.dart';
import 'package:uber_clone/screens/driver_contact/driver_contact.dart';
import 'package:uber_clone/screens/edit_account/edit_account.dart';
import 'package:uber_clone/screens/get_started/choose_account.dart';
import 'package:uber_clone/screens/get_started/choose_login_type.dart';
import 'package:uber_clone/screens/get_started/get_started.dart';
import 'package:uber_clone/screens/help/help.dart';
import 'package:uber_clone/screens/user_trips/trips.dart';
import 'package:uber_clone/screens/wallet/wallet.dart';
import 'package:uber_clone/services/firebase/authentication_service.dart';
import 'package:uber_clone/theme/theme.dart';


void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('main app rebuilded');
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (context) => AuthenticationService(),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        ),
        ChangeNotifierProvider(
          create: (context) => CachedDataProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        theme: AppTheme.appTheme(),
        initialRoute: '/',
        routes: {
          AuthenticationWrapper.route : (context) => AuthenticationWrapper(),
          GetStarted.route : (context) => GetStarted(),
          LoginTypePicker.route : (context ) => LoginTypePicker(),
          ChooseAccount.route : (context) => ChooseAccount(),
          //Home.route : (context) => Home(),
          UserTrips.route : (context) => ChangeNotifierProvider(
              create: (context) => TripsProvider(),
              child: UserTrips()),
          Help.route : (context) => Help(),
          Wallet.route : (context) => Wallet(),
          EditAccount.route : (context) => EditAccount(),
          DriverContact.route: (context) => DriverContact(mockDriver: ModalRoute.of(context).settings.arguments,),
          AccountSettings.route : (context) => AccountSettings(),
          Chats.route : (context) => Chats(),
          Chat.route: (context) => Chat(chatInfo: ModalRoute.of(context).settings.arguments,),
          RideVerification.route : (context) => ChangeNotifierProvider(
              create: (context) => RideVerificationProvider(),
              child: RideVerification()
          ),
        },
      ),
    );
  }
}

