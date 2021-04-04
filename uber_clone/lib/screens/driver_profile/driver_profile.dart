

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/profile_sliver.dart';
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/providers/driver_profile_provider.dart';
import 'package:uber_clone/providers/profile_pictures_provider.dart';
import 'package:uber_clone/screens/driver_profile/components/driver_info.dart';
import 'package:uber_clone/screens/driver_profile/components/trips_and_start.dart';
class DriverProfile extends StatefulWidget {

  static const route = '/driverProfile';

  @override
  _DriverProfileState createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {

  File? picture;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    String driverId = Provider.of<DriverProfileProvider>(context, listen: false).id;

    SchedulerBinding.instance!.addPostFrameCallback((_) async{
        File x = (await Provider.of<ProfilePicturesProvider>(context, listen: false).getDriverPicture(driverId))!;

        setState(() {
          picture = x;
        });
    });


  }

  @override
  Widget build(BuildContext context) {
    Driver? driver = Provider.of<DriverProfileProvider>(context).driver;
    if( picture == null || driver == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
        ),
        child: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              ProfileSliver(firstName: Provider.of<DriverProfileProvider>(context, listen: false).driver!.firstName, picture: picture,)
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TripsAndStart(numberOfTrips: driver.numberOfTrips!, dateOfStart: driver.dateOfStart!,),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Spacer(),
                          Spacer(),
                        ],
                      ),
                    ),
                    DriverInfo(shortDescription: 'This is a description', from: driver.from,),
                    Divider(height: 40, color: Colors.grey, thickness: 1,),
                    Row(
                      children: [
                        Expanded(
                            child: Text('Compliments and ratings', style: TextStyle(fontSize: 22),)
                        ),
                        GestureDetector(
                            onTap: () {

                            },
                            child: Text('View all', style: TextStyle(color: Colors.blue[900], fontSize: 24),)
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
