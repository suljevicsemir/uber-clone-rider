import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/providers/user_data_provider.dart';

class EditAccount extends StatefulWidget {

  static const route = '/editAccount';

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {

  final globalKey = GlobalKey<ScaffoldState>();




  @override
  Widget build(BuildContext context) {
    final UserData user = Provider.of<UserDataProvider>(context, listen: false).userData;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child : Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                      iconTheme: IconThemeData(
                          color: Colors.white
                      ),
                      brightness: Brightness.dark,
                      elevation: 0.0,
                      expandedHeight: MediaQuery.of(context).size.height * 0.45,
                      pinned: true,
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) {
                          return  FlexibleSpaceBar(
                            centerTitle: false,
                            title: Text( user.firstName, style: TextStyle(color: Colors.white, fontSize: 22),),
                            background: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    //image: FileImage(user.profilePicture),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                          );
                        },
                      )
                  ),
                ),
              )
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Image.asset(
                          'icons/flags/png/ba.png', package: 'country_icons',
                          scale: 2,
                        ),
                      ),
                      Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('  ${user.phoneNumber}', style: Theme.of(context).textTheme.headline6,)
                            ),
                          )
                      ),

                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('Verified' ,style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.green, fontWeight: FontWeight.w300),))
                    ],
                  ),
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
                          child: Text('Verified', style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.green, fontWeight: FontWeight.w300),))
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
                      Text('Connected', style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.green, fontWeight: FontWeight.w300),)
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
                      Text('Not Connected', style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.red),)
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
