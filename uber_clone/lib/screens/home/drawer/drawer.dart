import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:uber_clone/screens/home/drawer/drawer_header.dart';
import 'package:uber_clone/screens/home/drawer/drawer_item.dart';
class HomeDrawer extends StatefulWidget {

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {




  @override
  void initState() {
    super.initState();
    //changeStatusBarColor();
  }


  Future<void> changeStatusBarColor() async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.black, animate: false);
  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
      //elevation: 16.0,
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            HomeDrawerHeader(),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawerItem(itemTitle: 'Your Trips', route: '/userTrips', ),
                  DrawerItem(itemTitle: 'Help', route: '/help',),
                  DrawerItem(itemTitle: 'Wallet', route: '/wallet',),
                  DrawerItem(itemTitle: 'Settings', route: '/accountSettings',),
                  DrawerItem(itemTitle: 'Driver Profile', route: '/driverProfile')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
