

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/providers/location_provider.dart';
import 'package:uber_clone/screens/driver_profile/components/trips_and_start.dart';
import 'package:uber_clone/services/firebase/firebase_service.dart';

class DriverBottomSheet extends StatefulWidget {

  final String driverId;

  DriverBottomSheet({required this.driverId});


  @override
  _DriverBottomSheetState createState() => _DriverBottomSheetState();
}

class _DriverBottomSheetState extends State<DriverBottomSheet> {


  Driver? driver;
  late double averageScore;
  late String time, timeSubtitle, trips;
  @override
  void initState() {
    super.initState();

    //fetch driver
    Future.delayed(const Duration(milliseconds: 100), () async {
      FirebaseService.firestoreInstance.collection('drivers').doc(widget.driverId).get().then((DocumentSnapshot driverSnapshot) {
        //Map<String, String> map = driverSnapshot.get("rating");

        driver = Driver.fromSnapshot(driverSnapshot);

        Map<String, String> map = driver!.timeInService();
        time = map["time"]!;
        timeSubtitle = map["timeSubtitle"]!;
        trips = driver!.tripsToString();
        setState(() {


        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print( ( 550 / MediaQuery.of(context).size.height));
    return Container(
      height: 440,
      color: const Color(0xff2e2e2e),
      child: driver == null ? Container() :  Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 60,
              backgroundImage: NetworkImage(driver!.profilePictureUrl!),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(driver!.firstName + " " + driver!.lastName,
                style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 1.0)
              ),
            ),
            Container(

              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('4.1', style: TextStyle( fontSize: 22, color: Colors.white),),
                  SizedBox(width: 10,),
                  Icon(Icons.star, color: Colors.yellow,),
                  Icon(Icons.star, color: Colors.yellow,),
                  Icon(Icons.star, color: Colors.yellow,),
                  Icon(Icons.star, color: Colors.yellow,),
                  Icon(Icons.star_border_outlined)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TripsAndStart(
                  numberOfTrips: driver!.numberOfTrips!,
                  time: time,
                  timeSubtitle: timeSubtitle,
                  trips: trips,
                  )
            ),
            //Spacer(),
           // SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('Car:   ', style: TextStyle(color: Colors.white, fontSize: 22),),
                  Text(driver!.car!, style: TextStyle(color: Colors.white, fontSize: 20),)
                ],
              ),
            ),
            //Spacer(),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('Registration plates: ', style: TextStyle(color: Colors.white, fontSize: 22),),
                  Text(driver!.registrationPlates!, style: TextStyle(color: Colors.white, fontSize: 20),)
                ],
              ),
            ),
           Spacer(),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: ElevatedButton(
                onPressed: () {
                 print(Provider.of<LocationProvider>(context, listen: false).lastLocation!.latitude.toString());

                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Call for ride', style: TextStyle(fontSize: 20),),

                  ],
                ),
              ),
            )




          ],
        ),
      ),
    );
  }
}
