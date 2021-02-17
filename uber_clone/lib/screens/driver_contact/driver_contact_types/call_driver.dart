import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class CallDriver extends StatefulWidget {
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
    await Future.delayed(const Duration(milliseconds: 250), () {
      launch("tel://062972494");
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
