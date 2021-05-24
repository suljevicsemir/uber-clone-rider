import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/authentication_wrapper.dart';
import 'package:uber_clone/components/uber_router.dart';
import 'package:uber_clone/providers/internet_connectivity_provider.dart';
import 'package:uber_clone/providers/profile_pictures_provider.dart';
import 'package:uber_clone/providers/settings/account_settings.dart';
import 'package:uber_clone/providers/user_data_provider.dart';
import 'package:uber_clone/services/firebase/authentication_service.dart';
import 'package:uber_clone/theme/theme.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    print('main app rebuilded');
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (context) => AuthenticationService(),
        ),
        StreamProvider(
          initialData: null,
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        ),
        ChangeNotifierProvider(
          create: (context) => ProfilePicturesProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritePlacesProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        theme: AppTheme.appTheme(),
        initialRoute: AuthenticationWrapper.route,
        onGenerateRoute: UberRouter.generateRoute,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

