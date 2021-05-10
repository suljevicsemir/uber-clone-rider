import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/connectivity_notifier.dart';
import 'package:uber_clone/providers/home_provider.dart';
import 'package:uber_clone/screens/home/drawer/drawer.dart';
import 'package:uber_clone/screens/home/drawer_menu_icon.dart';
import 'package:uber_clone/screens/home/home_components/favorite_places/favorite_places.dart';
import 'package:uber_clone/screens/home/home_components/ride/ride_now.dart';
import 'package:uber_clone/screens/home/home_components/where_to.dart';
import 'package:uber_clone/screens/home/map/map.dart';
import 'dart:math' as math;
class Home extends StatefulWidget {
  static const String route = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final globalKey = GlobalKey<ScaffoldState>();
  Color statusBarColor = Colors.transparent;
  bool firstRun = false;
  bool expandMap = true;

  @override
  void initState() {
    super.initState();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!firstRun) {
      expandMap = Provider.of<HomeProvider>(context).isOverlayShown;
      setState(() {
        firstRun = false;
      });
    }
  }

  Future<Uint8List> resizeMapSnapshot(Uint8List snapshot) async {
    ui.Codec snapshotCodec = await ui.instantiateImageCodec(snapshot, targetWidth: 200, targetHeight: 50);
    ui.FrameInfo snapshotFrameInfo = await snapshotCodec.getNextFrame();
    Uint8List list = (await snapshotFrameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
    return list;
  }


  @override
  Widget build(BuildContext context) {

    //bool expandMap = Provider.of<HomeProvider>(context).isOverlayShown;

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

              //around you banner
              Positioned(
                  top: expandMap ? 500 : 0 ,
                  left: expandMap ? 20 : 0,
                  child: Container(
                    child: Text('Around you', style: TextStyle(fontSize: 20, fontFamily: 'OnePlusSans'))
                  )
              ),


              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: expandMap ? 600 : 0,
                left: expandMap ? 20 : 0,
                child: SizedBox(
                  width: expandMap ?  MediaQuery.of(context).size.width - 42 : MediaQuery.of(context).size.width,
                  height: expandMap ?  120 : MediaQuery.of(context).size.height,
                  child: HomeMap()
                ),
              ),

              expandMap ?
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
             ) : Container(),



              expandMap ?
              RideNow() :
              Container(),


              expandMap ?
              HomeFavoritePlaces() : Container(),






              expandMap ?
              Positioned(
                top: MediaQuery.of(context).size.height * 0.27,
                right: 0,
                child: Transform.rotate(
                    angle: - math.pi / 4,
                    child: Image.asset('assets/images/white_car.png', scale: 9.5,)
                ),
              ) : Container(),

              expandMap ?
              Positioned(
                top: 270,
                left: 20,
                right: 20,
                child: WhereTo()
              ) :
              Container(),

              //Drawer Menu Icon
              //DrawerMenu(),


            ]
          ),
        ),
        drawer: HomeDrawer(),
      ),
    );
  }


}
