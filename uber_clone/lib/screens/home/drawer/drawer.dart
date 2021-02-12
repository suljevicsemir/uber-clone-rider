import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uber_clone/screens/home/drawer/drawer_header.dart';
import 'package:uber_clone/screens/home/drawer/drawer_item.dart';
class HomeDrawer extends StatefulWidget {

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
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
                child: HomeDrawerHeader(),
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
      ),
    );
  }
}
