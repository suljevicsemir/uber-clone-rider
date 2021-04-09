import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/home_provider.dart';
import 'package:uber_clone/screens/home/drawer/drawer.dart';
import 'package:uber_clone/screens/home/drawer_menu_icon.dart';
import 'package:uber_clone/screens/home/map/map.dart';

import 'file:///C:/Users/semir/FlutterProjects/uber-clone-rider/uber_clone/lib/screens/home/home_components/pick_destination.dart';
import 'file:///C:/Users/semir/FlutterProjects/uber-clone-rider/uber_clone/lib/screens/home/home_components/ride_now.dart';

class Home extends StatefulWidget {
  static const String route = '/home';


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final globalKey = GlobalKey<ScaffoldState>();
  Color statusBarColor = Colors.transparent;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: globalKey,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light
        ),
        child: Stack(
          fit: StackFit.loose,
          children: [

            HomeMap(),



            Provider.of<HomeProvider>(context).isOverlayShown ?
            //BOTTOM WHERE TO AND SAVED PLACE PART
            PickDestination() : Container(),

            Provider.of<HomeProvider>(context).isOverlayShown ?
            //BLUE RIDE NOW PART
            RideNow() : Container(),

            //Drawer Menu Icon
            DrawerMenu(),


          ]
        ),
      ),
      drawer: HomeDrawer(),
    );
  }


}
