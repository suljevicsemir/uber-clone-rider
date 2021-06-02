

import 'package:flutter/material.dart';
import 'package:uber_clone/models/driver.dart';

class DriverBottomSheet extends StatefulWidget {

  final String driverId;

  DriverBottomSheet({required this.driverId});


  @override
  _DriverBottomSheetState createState() => _DriverBottomSheetState();
}

class _DriverBottomSheetState extends State<DriverBottomSheet> {


  Driver? driver;


  @override
  void initState() {
    super.initState();

    //fetch driver
    Future.delayed(const Duration(milliseconds: 100), () async {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
    );
  }
}
