import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/trips_provider.dart';
import 'package:uber_clone/screens/user trips/sliver app bar/ride_type_picker.dart';
import 'package:uber_clone/screens/user%20trips/ride_type.dart';
import 'package:uber_clone/screens/user%20trips/ride_type_divider.dart';
class UserTrips extends StatefulWidget {
  static const route = '/userTrips';
  @override
  _UserTripsState createState() => _UserTripsState();
}

class _UserTripsState extends State<UserTrips> with TickerProviderStateMixin {

  /*EdgeInsetsDirectional beforeIcon = EdgeInsetsDirectional.only(

  )*/

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
                      //print(constraints.biggest.height.toString());
                      return FlexibleSpaceBar(
                        titlePadding: EdgeInsetsDirectional.only(start: 100 - constraints.biggest.height * 0.4, bottom: 18),
                          title: Text('Choose a trip'),
                          stretchModes: [
                            StretchMode.zoomBackground
                          ],
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

            AnimatedSize(
              vsync: this,
                duration: const Duration(milliseconds: 300),
                child: Provider.of<TripsProvider>(context).shown ?
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RideType(rideType: 'Past',),
                      RideTypeDivider(),
                      RideType(rideType: 'Business',),
                      RideTypeDivider(),
                      RideType(rideType: 'Upcoming',)
                    ],
                  ),
                ) : Container()
            ),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                color: Provider.of<TripsProvider>(context,listen: false).shown ?  const Color(0xff2e2e2e) : Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('You havent taken a trip yet', style: TextStyle(fontSize: 26),)
                  ],
                ),
              ),
            ),

          ],
        )
      ),
    );
  }
}
