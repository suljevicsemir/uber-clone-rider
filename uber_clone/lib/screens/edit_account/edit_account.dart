

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/services/authentication_service.dart';

class EditAccount extends StatefulWidget {

  static const route = '/editAccount';

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthenticationService>(context, listen: false).currentUser;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      child : Scaffold(
        key: globalKey,
        body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(

                    stretch: true,
                    brightness: Brightness.dark,
                    iconTheme: IconThemeData(
                      color: Colors.white,
                      size: 34
                    ),
                    elevation: 0.0,
                    expandedHeight: 400,
                    pinned: true,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      //titlePadding: EdgeInsets.only(),
                      centerTitle: true,

                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('sahjdhasjhdkajs', style: TextStyle(color: Colors.black),),
                          Text('sahjdhasjhdkajs', style: TextStyle(color: Colors.black),),
                        ],
                      ),
                      background:Image.asset('assets/images/new_york.jpg', fit: BoxFit.cover,),
                    ),
                  ),
                ),
              ),

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
                  Text(user.displayName, style: Theme.of(context).textTheme.headline6,),
                  SizedBox(height: 40,),
                  Text('Last Name', style: Theme.of(context).textTheme.headline5,),
                  SizedBox(height: 10,),
                  Text(user.displayName, style: Theme.of(context).textTheme.headline6,),
                  SizedBox(height: 40,),
                  Text('Phone number', style: Theme.of(context).textTheme.headline5,),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          'icons/flags/png/ba.png', package: 'country_icons',

                          scale: 2,
                        ),
                      ),
                      Text(' +387 62 972 494', style: Theme.of(context).textTheme.headline6,),
                      Spacer(),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('Verified' ,style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.green),))
                    ],
                  ),
                  SizedBox(height: 40,),
                  Text('Email', style: Theme.of(context).textTheme.headline5,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(user.email, style: Theme.of(context).textTheme.headline6,),
                      Spacer(),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('Verified', style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.green),))
                    ],
                  ),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.google, color: Colors.blue,),
                      SizedBox(width: 20,),
                      Text('Google', style: Theme.of(context).textTheme.headline6,),
                      Spacer(),
                      Text('Connected', style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.green),)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
