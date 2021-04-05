import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uber_clone/screens/driver_profile/driver_profile.dart';

class OpenDriverProfile extends StatefulWidget {


  final String driverId;

  OpenDriverProfile({required this.driverId});

  @override
  _OpenDriverProfileState createState() => _OpenDriverProfileState();
}

class _OpenDriverProfileState extends State<OpenDriverProfile> {

  bool pressed = false;

  void changePressedValue() {
    setState(() {
      pressed = !pressed;
    });
  }

  Future<void> onLongPress() async {
    changePressedValue();
    Timer(const Duration(milliseconds: 450), () => changePressedValue());

  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        changePressedValue();
        await Navigator.pushNamed(context, DriverProfile.route, arguments: widget.driverId);
        changePressedValue();
      },
      onLongPress: onLongPress,
      child: AnimatedContainer(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 5),
          duration: const Duration(milliseconds: 300),
          color: pressed ? Colors.grey : Colors.transparent,
          curve: Curves.fastOutSlowIn,
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(Icons.account_circle),
                SizedBox(width: 20,),
                Text('Open profile', style: TextStyle(fontSize: 20),)
              ],
            ),
          )
      ),
    );
  }
}
