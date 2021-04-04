import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/profile_pictures_provider.dart';
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

              //Drawer Menu Icon
              DrawerMenu(),

              Positioned(
                  left: 80.0,
                  top: 10.0,
                  child: ClipOval(
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        splashColor: Colors.black,
                        child: SizedBox(
                          height: 55,
                          width: 55,
                          child: Icon(Icons.menu, size: 30,),
                        ),
                        onTap: () => Provider.of<ProfilePicturesProvider>(context, listen: false).tempDirectoryService.deleteDriverDirectory(),
                      ),
                    ),
                  )
              )
            ]
          )
        ),
      ),
      drawer: HomeDrawer(),
    );
  }


}
