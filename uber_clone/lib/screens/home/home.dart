import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/cached_data_service.dart';
import 'package:uber_clone/screens/home/drawer/drawer.dart';
import 'package:uber_clone/screens/home/drawer_menu_icon.dart';
import 'package:uber_clone/screens/home/pick_destination.dart';
import 'package:uber_clone/screens/home/ride_now.dart';

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



  Future<void> changeStatusBarColor() async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent, animate: true);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: globalKey,
      backgroundColor: Colors.grey,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor:  Colors.transparent,
          statusBarIconBrightness: Brightness.light
        ),
        child: SafeArea(
          child: Stack(
            fit: StackFit.loose,
            children: [

              //BOTTOM WHERE TO AND SAVED PLACE PART
              PickDestination(),

              //BLUE RIDE NOW PART
              RideNow(),

              Positioned(
                  left: 90.0,
                  top: 10.0,
                  child: ClipOval(
                    child: Material(
                      color: Colors.green,
                      child: InkWell(
                        splashColor: Colors.black,
                        child: SizedBox(
                          height: 55,
                          width: 55,
                          child: Icon(Icons.menu, size: 30,),
                        ),
                        onTap: () async =>  await Provider.of<CachedDataService>(context, listen: false).deleteDriverDirectory(),
                      ),
                    ),
                  )
              ),
              Positioned(
                  left: 180.0,
                  top: 10.0,
                  child: ClipOval(
                    child: Material(
                      color: Colors.green,
                      child: InkWell(
                        splashColor: Colors.black,
                        child: SizedBox(
                          height: 55,
                          width: 55,
                          child: Icon(Icons.menu, size: 30,),
                        ),
                        onTap: () async =>  await Provider.of<CachedDataService>(context, listen: false).deleteUserPicture(),
                      ),
                    ),
                  )
              ),

              //Drawer Menu Icon
              DrawerMenu(),
            ]
          )
        ),
      ),
      drawer: HomeDrawer(),
    );
  }


}
