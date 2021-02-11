import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/screens/home/drawer/drawer_item.dart';
import 'package:uber_clone/services/authentication_service.dart';
class HomeDrawer extends StatefulWidget {

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthenticationService>(context, listen: false).currentUser;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.black
      ),
      child: Drawer(
        elevation: 0.0,
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 200,
                child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),

                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(user.photoURL),
                                backgroundColor: Colors.transparent,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                                  child: Text(user.displayName, style: TextStyle(color: Colors.white),))
                            ],
                          ),
                          Divider(color: Colors.grey, height: 50,),
                          Row(
                            children: [
                              Text('Messages', style: TextStyle(color: Colors.white),),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: ClipOval(
                                  child: Container(
                                    color: Colors.blue,
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.keyboard_arrow_right, color: Colors.white,)
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrawerItem(itemTitle: 'Your Trips',),
                    DrawerItem(itemTitle: 'Help',),
                    DrawerItem(itemTitle: 'Waller',),
                    DrawerItem(itemTitle: 'Settings',),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
