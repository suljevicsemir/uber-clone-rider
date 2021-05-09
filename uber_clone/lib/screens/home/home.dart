import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/connectivity_notifier.dart';
import 'package:uber_clone/providers/home_provider.dart';
import 'package:uber_clone/screens/home/drawer/drawer.dart';
import 'package:uber_clone/screens/home/drawer_menu_icon.dart';
import 'package:uber_clone/screens/home/home_components/favorite_places.dart';
import 'package:uber_clone/screens/home/home_components/ride_now.dart';
import 'package:uber_clone/screens/home/home_components/where_to.dart';
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
    return WillPopScope(
      onWillPop: () async {
        if(!Provider.of<HomeProvider>(context, listen: false).isOverlayShown) {
          Provider.of<HomeProvider>(context, listen: false).updateOverlay();
          return false;
        }
        return true;
      },
      child: Scaffold(
        key: globalKey,
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light
          ),
          child: Stack(
            fit: StackFit.loose,
            children: [

              //HomeMap(),


             Positioned(
               top: 0,
               child: Container(
                 width: MediaQuery.of(context).size.width,
                 height: 250,
                 decoration: BoxDecoration(
                   color: const Color(0xff286ef0),
                   borderRadius: BorderRadius.only(
                     bottomRight: Radius.circular(150)
                   )
                 ),
               ),
             ),

             Positioned(
              top: 100,
              left: 20,
              child: RideNow(),
            ),


              HomeFavoritePlaces(),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.27,
                right: 0,
                child: Transform.rotate(
                    angle: - math.pi / 4,
                    child: Image.asset('assets/images/white_car.png', scale: 9.5,)
                ),
              ),




              Positioned(
                top: 270,
                left: 20,
                right: 20,
                child: WhereTo()
              ),


              //Drawer Menu Icon
              DrawerMenu(),

              Positioned(
                top: 50,
                left: 80,
                right: 0,
                child: ConnectivityNotifier()
              ),




            ]
          ),
        ),
        drawer: HomeDrawer(),
      ),
    );
  }


}
