


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrackDriver extends StatefulWidget {

  final bool openedFromNotification;
  final String? driverId;

  TrackDriver({
    required this.openedFromNotification,
    this.driverId
  });

  @override
  _TrackDriverState createState() => _TrackDriverState();
}

class _TrackDriverState extends State<TrackDriver> {


  static const platform = const MethodChannel("RideIdFetcher");
  String driverId = "driver id not loaded";
  String rideId = "ride id not loaded";
  Future<void> getRideId() async {
    try {
      String idFromNative = await platform.invokeMethod("getRideId");
      setState(() {
        rideId = idFromNative;
      });

    }on PlatformException catch(e) {
      print(e.message);
    }
  }

  Future<void> getDriverId() async {
    try {
      String idFromNative = await platform.invokeMethod("getDriverId");
      setState(() {
        driverId = idFromNative;
      });
    }
    on PlatformException catch(e) {
      print(e.message);
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light
        ),
        child: Stack(
          children: [
            Positioned(
              top: 100,
              child: Text(rideId),
            ),
            Positioned(
              top: 100,
              left: 200,
              child: Text(driverId),
            ),

            Positioned(
              top: 500,
              child: ElevatedButton(
                onPressed: () => getRideId(),
                child: Text('click for ride'),
              ),
            ),
            Positioned(
              top: 500,
              left: 150,
              child: ElevatedButton(
                onPressed: () => getRideId(),
                child: Text('click for driver'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
