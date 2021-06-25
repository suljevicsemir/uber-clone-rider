import 'package:flutter/material.dart';

class TripsAndStart extends StatelessWidget {

  final int numberOfTrips;
  final String time, timeSubtitle, trips;

  TripsAndStart({
    required this.numberOfTrips,
    required this.timeSubtitle,
    required this.time,
    required this.trips
  });

  final TextStyle subtitle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w300
  );

  final TextStyle content = TextStyle(
      fontSize: 24,
      letterSpacing: 0.8,
      fontWeight: FontWeight.w400
  );








  @override
  Widget build(BuildContext context) {

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
                Text(trips, style: content),
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
