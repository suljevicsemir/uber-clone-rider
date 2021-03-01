import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/authentication_wrapper.dart';
import 'package:uber_clone/services/authentication_service.dart';
import 'package:uber_clone/theme/palette.dart';

class AccountSettings extends StatefulWidget {

  static const String route = '/accountSettings';

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {


  final TextStyle accountInfoStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Colors.black
  );

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthenticationService>(context, listen: false).currentUser;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Account settings'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/editAccount'),
              style: Palette.greyElevatedStyleLeftPadding,
              child: Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(user.photoURL),
                      backgroundColor: Colors.transparent,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.displayName, style: accountInfoStyle,),
                          Text('+387 62 972 494', style: accountInfoStyle,),
                          Text(user.email, style: accountInfoStyle,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(color: Colors.grey, height: 20, thickness: 0.5,),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text('Favorites', style: Theme.of(context).textTheme.headline3,)
                    ),
                    SizedBox(height: 25,),
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ElevatedButton.icon(
                          style: Palette.greyElevatedStyleLeftPadding,
                          onPressed: () {},
                          icon: Icon(Icons.home_filled, color: Colors.black,),
                          label: Text('Add Home', style: Theme.of(context).textTheme.headline3.copyWith(fontWeight: FontWeight.w400)),
                        ),
                        ElevatedButton.icon(
                          style: Palette.greyElevatedStyleLeftPadding,
                          onPressed: () {},
                          icon: Icon(Icons.work, color: Colors.black,),
                          label: Text('Add Work', style: Theme.of(context).textTheme.headline3.copyWith(fontWeight: FontWeight.w400)),
                        ),
                        ElevatedButton(
                          style: Palette.greyElevatedStyleLeftPadding,
                          onPressed: () {},
                          child: Text('More Saved places', style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.w400),),
                        )
                      ],
                    ),

                  ],
                )
            ),
            Divider(color: Colors.grey, height: 30, thickness: 0.5,),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text('Safety', style: Theme.of(context).textTheme.headline3),
                    ),
                    SizedBox(height: 25,),
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ElevatedButton.icon(
                            style: Palette.greyElevatedStyleAllPadding,
                            onPressed: () {},
                            icon: Icon(Icons.quick_contacts_dialer_rounded, color: Colors.black,),
                            label: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Manage Trusted Contacts', style: Theme.of(context).textTheme.headline3.copyWith(fontWeight: FontWeight.w400)),
                                  Container(
                                    width: MediaQuery.of(context).size.width - 100,
                                    child: Text('Share your trip status with family and friends in a single tap',
                                      style: Theme.of(context).textTheme.headline4),
                                  ),
                                ],
                              ),
                            )
                        ),
                        ElevatedButton.icon(
                            style: Palette.greyElevatedStyleAllPadding,
                            onPressed: () async => await Navigator.pushNamed(context, '/rideVerification'),
                            icon: Icon(Icons.fiber_pin, color: Colors.black,),
                            label: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Verify Your Ride', style: Theme.of(context).textTheme.headline3),
                                  Container(
                                    width: MediaQuery.of(context).size.width - 100,
                                    child: Text('Use a PIN to make sure you get in the right car',
                                      style: Theme.of(context).textTheme.headline4,),
                                  ),
                                ],
                              ),
                            )
                        ),
                        ElevatedButton.icon(
                            style: Palette.greyElevatedStyleAllPadding,
                            onPressed: () {},
                            //TODO import custom icon
                            icon: Icon(Icons.car_rental, color: Colors.black,),
                            label: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('RideCheck', style: Theme.of(context).textTheme.headline3),
                                  Container(
                                    width: MediaQuery.of(context).size.width - 100,
                                    child: Text('Manage your RideCheck notifications',
                                    style: Theme.of(context).textTheme.headline4),
                                  ),
                                ],
                              ),
                            )
                        )
                      ],
                    )
                  ],
                )
            ),
            Divider(height: 30, thickness: 0.5, color: Colors.grey,),
            ElevatedButton(
                  style: Palette.greyElevatedStyleAllPadding,
                  onPressed: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Privacy', style: Theme.of(context).textTheme.headline3.copyWith(fontWeight: FontWeight.w400),),
                      Text('Manage the data you share with us', style: Theme.of(context).textTheme.headline4,)
                    ],
                  )
              ),
            Divider(height: 30, color: Colors.grey, thickness: 0.5,),
            ElevatedButton(
                style: Palette.greyElevatedStyleAllPadding,
                onPressed: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Security', style: Theme.of(context).textTheme.headline3,),
                    Text('Control your account security with 2-step verification',
                        style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                )
            ),
            Divider(height: 30, color: Colors.grey, thickness: 0.5,),
            ElevatedButton(
                style: Palette.greyElevatedStyleAllPadding,
                onPressed: () async {
                  await Provider.of<AuthenticationService>(context, listen: false).signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationWrapper()), (_) => false);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sign out', style: Theme.of(context).textTheme.headline3,),
                  ],
                )
            ),
            SizedBox(height: 20,)

          ],
        )
      ),
    );
  }
}
