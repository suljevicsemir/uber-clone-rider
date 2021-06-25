import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/trips_provider.dart';
import 'package:uber_clone/screens/user_trips/trips_body/past_trips/past_trip.dart';
class TripsBodyBuilder extends StatefulWidget {
  @override
  _TripsBodyBuilderState createState() => _TripsBodyBuilderState();
}

class _TripsBodyBuilderState extends State<TripsBodyBuilder> {
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: Provider.of<TripsProvider>(context, listen: false).tripType.typeToIndex(),
      children: [
        AnimatedContainer(
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
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          color: Provider.of<TripsProvider>(context).shown ?  const Color(0xff2e2e2e) : const Color(0xff3c4154),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('This is business'),
              Text('das')
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
         // padding: EdgeInsets.all(50),
          color: Provider.of<TripsProvider>(context).shown ?  const Color(0xff2e2e2e) : const Color(0xff3c4154),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('This is upcoming'),
              Text('sadhas')
            ],
          ),
        ),
      ],
    );
  }
}
