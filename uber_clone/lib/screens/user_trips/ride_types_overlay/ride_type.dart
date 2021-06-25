import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/trips_provider.dart';

class RideType extends StatelessWidget{

  final TripType tripType;
  RideType({required this.tripType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<TripsProvider>(context, listen: false).shown = false;
        Provider.of<TripsProvider>(context, listen: false).tripType = tripType;
      },
      splashColor: Colors.grey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          margin: EdgeInsets.only(left: 20),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: [
              Text(tripType.parseTripType(), style: TextStyle(fontSize: 18),),
              Spacer(),
              Provider.of<TripsProvider>(context, listen: false).tripType == tripType ?
              Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Icon(Icons.check)
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}



