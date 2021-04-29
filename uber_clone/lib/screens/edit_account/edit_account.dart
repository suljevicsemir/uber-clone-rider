import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/profile_sliver.dart';
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/providers/profile_pictures_provider.dart';
import 'package:uber_clone/providers/user_data_provider.dart';

class EditAccount extends StatefulWidget {

  static const route = '/editAccount';

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {

  final globalKey = GlobalKey<ScaffoldState>();


  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final UserData? user = Provider.of<UserDataProvider>(context, listen: false).userData;
    final File? picture = Provider.of<ProfilePicturesProvider>(context).profilePicture;

    if( user == null || picture == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child : Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              ProfileSliver(picture: picture, firstName: user.firstName, hasEdit: true,)
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 30, color: Colors.grey, thickness: 0.5,),
                  Text('First Name', style: Theme.of(context).textTheme.headline5,),
                  SizedBox(height: 10,),
                  Text(user.firstName, style: Theme.of(context).textTheme.headline6,),
                  SizedBox(height: 40,),
                  Text('Last Name', style: Theme.of(context).textTheme.headline5,),
                  SizedBox(height: 10,),
                  Text(user.lastName, style: Theme.of(context).textTheme.headline6,),
                  SizedBox(height: 40,),
                  Text('Phone number', style: Theme.of(context).textTheme.headline5,),
                  SizedBox(height: 10,),
                  SizedBox(height: 40,),
                  Text('Email', style: Theme.of(context).textTheme.headline5,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                          child: Text( user.email, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,)
                      ),
                     // Spacer(),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('Verified', style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.green, fontWeight: FontWeight.w300),))
                    ],
                  ),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Image.asset(
                        user.signedInType == SignedInType.Google ?  'assets/images/google_icon.png' : 'assets/images/facebook_icon.png',
                        scale: 15,
                      ),
                      SizedBox(width: 20,),
                      Text( user.signedInType.parseSignedInType() , style: Theme.of(context).textTheme.headline6,),
                      Spacer(),
                      Text('Connected', style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.green, fontWeight: FontWeight.w300),)
                    ],
                  ),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Image.asset(
                        user.signedInType != SignedInType.Google ? 'assets/images/google_icon.png' : 'assets/images/facebook_icon.png',
                        scale: 15,
                      ),
                      SizedBox(width: 20,),
                      Text(user.signedInType == SignedInType.Google ? 'Facebook' : 'Google', style: Theme.of(context).textTheme.headline6,),
                      Spacer(),
                      Text('Not Connected', style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.red),)
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
