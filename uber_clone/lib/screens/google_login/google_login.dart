
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/authentication_wrapper.dart';
import 'package:uber_clone/models/google_sign_result.dart';
import 'package:uber_clone/providers/google_login_provider.dart';
import 'package:uber_clone/providers/profile_pictures_provider.dart';
import 'package:uber_clone/providers/settings/account_settings.dart';
import 'package:uber_clone/providers/user_data_provider.dart';
import 'package:uber_clone/screens/google_login/sign_in_failed.dart';

class GoogleLogin extends StatefulWidget {

  static const String route = '/googleLogin';

  @override
  _GoogleLoginState createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {


  final TextStyle style = TextStyle(
    fontSize: 18
  );



  @override
  Widget build(BuildContext context) {




    if(Provider.of<GoogleLoginProvider>(context).progress.result == GoogleSignInResult.Cancelled) {

      return SignInFailed();
    }

    return Scaffold(
      //backgroundColor: const Color(0xff286ef0),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.grey[50],
            statusBarIconBrightness: Brightness.dark
        ),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Just a few moments...', style: TextStyle(fontSize: 22),),
                        Row(
                          children: [
                            Text('Signing in Google ...', style: style,),
                            const Icon(Icons.done, color: Colors.green,)
                          ],
                        ),
                        Row(
                          children: [
                            Text('Account authentication ...', style: style,),
                            Provider.of<GoogleLoginProvider>(context).progress.accountAuthentication ? const Icon(Icons.done, color: Colors.green,) : const SizedBox(
                                height: 20,
                                width: 20,
                                child: const CircularProgressIndicator()
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Signing in Uber ...', style: style,),
                            Provider.of<GoogleLoginProvider>(context).progress.uberSignIn ? const Icon(Icons.done, color: Colors.green,) : const SizedBox(
                                height: 20,
                                width: 20,
                                child: const CircularProgressIndicator()
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Saving your data ...', style: style,),
                            Provider.of<GoogleLoginProvider>(context).progress.savingData ? const Icon(Icons.done, color: Colors.green,) : const SizedBox(
                                height: 20,
                                width: 20,
                                child: const CircularProgressIndicator()
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Fetching profile picture ...', style: style,),
                            Provider.of<GoogleLoginProvider>(context).progress.storingPicture ? const Icon(Icons.done, color: Colors.green,) : const SizedBox(
                                height: 20,
                                width: 20,
                                child: const CircularProgressIndicator()
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //Spacer(),
                Provider.of<GoogleLoginProvider>(context).progress.result == GoogleSignInResult.Success ?
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: Material(
                        color: Colors.black,
                        child: InkWell(
                          splashColor: Colors.white,
                          onTap: () async {
                            Provider.of<UserDataProvider>(context, listen: false).userData = Provider.of<GoogleLoginProvider>(context, listen: false).userData;
                            await Provider.of<ProfilePicturesProvider>(context, listen: false).loadCachedData();
                            await Provider.of<FavoritePlacesProvider>(context, listen: false).loadFavoritePlaces();
                            await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationWrapper()), (_) => false);
                          },
                          child: Center(child: Text('Continue', style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
