import 'package:flutter/material.dart';

import 'file:///C:/Users/semir/FlutterProjects/uber-clone/uber_clone/lib/screens/user%20trips/ride_types_overlay/ride_type.dart';
import 'file:///C:/Users/semir/FlutterProjects/uber-clone/uber_clone/lib/screens/user%20trips/ride_types_overlay/ride_type_divider.dart';
class RideTypesOverlap extends StatefulWidget {



  @override
  _RideTypesOverlapState createState() => _RideTypesOverlapState();
}

class _RideTypesOverlapState extends State<RideTypesOverlap> with SingleTickerProviderStateMixin{




  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      child:  Container(
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
      )
    );
  }
}
