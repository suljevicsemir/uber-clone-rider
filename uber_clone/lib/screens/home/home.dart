import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/home_provider.dart';
import 'package:uber_clone/screens/home/drawer/drawer.dart';
import 'package:uber_clone/screens/home/home_components/favorite_places/favorite_places.dart';
import 'package:uber_clone/screens/home/home_components/ride/ride_now.dart';
import 'package:uber_clone/screens/home/home_components/ride/ride_now_background.dart';
import 'package:uber_clone/screens/home/home_components/ride/ride_now_icon.dart';
import 'package:uber_clone/screens/home/home_components/where_to.dart';
import 'package:uber_clone/screens/home/map/map.dart';

class Home extends StatefulWidget {
  static const String route = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

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

              Positioned(
                top: expandMap ? 470 : 0,
                left: expandMap ? 20 : 0,
                child: AnimatedSize(
                  vsync: this,
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: expandMap ?  MediaQuery.of(context).size.width - 42 : MediaQuery.of(context).size.width,
                    height: expandMap ?  MediaQuery.of(context).size.height - 480 : MediaQuery.of(context).size.height,
                    child: HomeMap(),
                  ),
                ),
              ),

              // around you banner
              expandMap ?
              Positioned(
                  top: expandMap ? 440 : 0 ,
                  left: expandMap ? 20 : 0,
                  child: Container(
                      child: Text('Around you', style: TextStyle(fontSize: 20, fontFamily: 'OnePlusSans'))
                  )
              ) : Container(),


              expandMap ?
              RideNowBackground() : Container(),

              expandMap ?
              RideNow() : Container(),

              expandMap ?
              HomeFavoritePlaces() : Container(),


              // car icon overlay
              expandMap ?
              RideNowIcon() : Container(),

              expandMap ?
              WhereTo() : Container(),
            ]
          ),
        ),
        drawer: HomeDrawer(),
      ),
    );
  }


}
