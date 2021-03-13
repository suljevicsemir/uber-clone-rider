import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class CallDriver extends StatefulWidget {

  final String phoneNumber;


  CallDriver({@required this.phoneNumber});

  @override
  _CallDriverState createState() => _CallDriverState();
}

class _CallDriverState extends State<CallDriver> {


  bool pressed = false;
  void changePressedValue() {
    setState(() {
      pressed = !pressed;
    });
  }

  Future<void> onTap() async {
    changePressedValue();
    final uri = "tel://" + widget.phoneNumber;
    if(await canLaunch("tel://" + widget.phoneNumber)) {
      launch(uri);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('Problem with dialing driver number'))
      );
    }
    await Future.delayed(const Duration(milliseconds: 250), () {

      changePressedValue();
    });
  }

  Future<void> onLongPress() async {
    changePressedValue();
    Timer(const Duration(milliseconds: 450), () => changePressedValue());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                Icon(Icons.phone),
                SizedBox(width: 20,),
                Text('Call driver', style: TextStyle(fontSize: 20),)
              ],
            ),
          )
      ),
    );
  }
}
