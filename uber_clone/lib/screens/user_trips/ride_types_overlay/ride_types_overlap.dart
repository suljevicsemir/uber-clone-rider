import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/trips_provider.dart';

import 'file:///C:/Users/semir/FlutterProjects/uber-clone/uber_clone/lib/screens/user_trips/ride_types_overlay/ride_type.dart';
import 'file:///C:/Users/semir/FlutterProjects/uber-clone/uber_clone/lib/screens/user_trips/ride_types_overlay/ride_type_divider.dart';
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
        child: Provider.of<TripsProvider>(context).shown ?    Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RideType(tripType: TripType.Past,),
            RideTypeDivider(),
            RideType(tripType: TripType.Business,),
            RideTypeDivider(),
            RideType(tripType: TripType.Upcoming,)
          ],
        ) : Container(),
      )
    );
  }
}
