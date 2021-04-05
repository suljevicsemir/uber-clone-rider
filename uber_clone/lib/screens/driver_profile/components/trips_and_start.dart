import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TripsAndStart extends StatelessWidget {

  final int numberOfTrips;
  final Timestamp dateOfStart;

  TripsAndStart({required this.numberOfTrips, required this.dateOfStart});

  final TextStyle subtitle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w300
  );

  final TextStyle content = TextStyle(
      fontSize: 24,
      letterSpacing: 0.8,
      fontWeight: FontWeight.w400
  );

  late String time, convertedTrips, timeSubtitle;

  //converts the driver's date of start
  //from timestamp into days, months or years
  void convertTime() {
    final Duration duration = DateTime.now().difference(dateOfStart.toDate());
    if( duration.inSeconds < 86400 * 30) {
      int value = 0;
      timeSubtitle = "Days";
      value = duration.inSeconds ~/ 86400;
      time = value.toString();
    }
    else if( duration.inSeconds < 86400 * 30 * 12) {
      int value = 0;
      timeSubtitle = "Months";
      value = duration.inSeconds ~/ (86400 * 30);
      time = value.toString();
    }
    else {
      double value = 0;
      int years = (duration.inSeconds / (86400 * 365)).truncate();
      double months = (duration.inSeconds - (years * 365 * 86400)) / (30 * 86400);
      value = years + months / 12;
      timeSubtitle = "Years";
      time = value.toStringAsFixed(1);

    }
  }

  void convertTrips() {
    convertedTrips = "";
    if(numberOfTrips > 1000)
      convertedTrips = convertedTrips + (numberOfTrips ~/ 1000).toString() + ",";

    convertedTrips = convertedTrips + (numberOfTrips % 1000).toString();
  }


  @override
  Widget build(BuildContext context) {
    convertTrips();
    convertTime();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: Colors.black.withOpacity(0.1),
              width: 2
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 2)
            )
          ]

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(convertedTrips, style: content),
                Text('Trips', style: subtitle)
              ],
            ),
          ),
          Container(
            height: 50,
            width: 4,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.35),
                borderRadius: BorderRadius.circular(20)
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(time, style: content),
                Text(timeSubtitle, style: subtitle)
              ],
            ),
          )
        ],
      ),
    );
  }
}
