import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/profile_sliver.dart';
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/providers/profile_pictures_provider.dart';
import 'package:uber_clone/screens/driver_contact/contact_buttons.dart';
import 'package:uber_clone/screens/driver_contact/expand_body.dart';

class DriverContact extends StatefulWidget {

  static const route = '/driverContact';
  final Driver driver;

  DriverContact({required this.driver});

  @override
  _DriverContactState createState() => _DriverContactState();
}

class _DriverContactState extends State<DriverContact> with TickerProviderStateMixin{

  double top = 0;
  File? picture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      File x = (await Provider.of<ProfilePicturesProvider>(context, listen: false).getDriverPicture(widget.driver.id))!;
      setState(() {
        picture = x;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    if( picture == null)
      return Center(
        child: CircularProgressIndicator(),
    );

    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
        ),
        child: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              ProfileSliver(picture: picture, firstName: widget.driver.firstName,)
            ];
          },
          body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ContactButtons(driver: widget.driver),
                SizedBox(height: 20,),
                ExpandBody(phoneNumber: widget.driver.phoneNumber, driverId: widget.driver.id)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
