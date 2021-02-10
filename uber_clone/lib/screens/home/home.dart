import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uber_clone/screens/home/drawer_menu_icon.dart';
import 'package:uber_clone/screens/home/pick_destination.dart';
import 'package:uber_clone/screens/home/ride_now.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final globalKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
   // SystemChrome.setEnabledSystemUIOverlays([]);
    var x= MediaQuery.of(context).size.height;
    print(x.toString());
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      ),
      child: Scaffold(
        key: globalKey,
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Stack(
            fit: StackFit.loose,
            children: [

              //BOTTOM WHERE TO AND SAVED PLACE PART
              PickDestination(),
              //BLUE RIDE NOW PART
              RideNow(),
              //Drawer Menu Icon
              DrawerMenu(),
            ]
          )
        ),
        drawer: Drawer(),
      ),
    );
  }


}
