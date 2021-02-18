import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/trips_provider.dart';
import 'package:uber_clone/screens/user_trips/ride_types_overlay/ride_types_overlap.dart';
import 'package:uber_clone/screens/user_trips/sliver_app_bar/ride_type_picker.dart';
import 'package:uber_clone/screens/user_trips/trips_body/past_trips/past_trip.dart';
class UserTrips extends StatefulWidget {
  static const route = '/userTrips';
  @override
  _UserTripsState createState() => _UserTripsState();
}

class _UserTripsState extends State<UserTrips> with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    //changeStatusBarColor();
  }


  void changeStatusBarColor() async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
  }



  double height = 0;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return<Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  pinned: true,
                  expandedHeight: 100,
                  actions: [
                    RideTypePicker()
                  ],
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      return FlexibleSpaceBar(
                        titlePadding: EdgeInsetsDirectional.only(start: 50, bottom: 15),
                          title: Text('Choose a trip', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06, fontWeight: FontWeight.w300),),
                        background: Container(
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

          ];
        },
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RideTypesOverlap(),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  bool isShown = Provider.of<TripsProvider>(context ,listen: false).shown;
                  if( isShown) {
                    Provider.of<TripsProvider>(context, listen: false).shown = false;
                  }

                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  color: Provider.of<TripsProvider>(context).shown ?  const Color(0xff2e2e2e) : const Color(0xff3c4154),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('You havent taken a trip yet', style: TextStyle(fontSize: 26),),
                      PastTrip(),
                      SizedBox(height: 20,),
                      PastTrip()

                    ],
                  ),
                ),
              ),
            ),

          ],
        )
      ),
    );
  }


}
