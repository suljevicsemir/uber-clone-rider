import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class SMSDriver extends StatefulWidget {
  @override
  _SMSDriverState createState() => _SMSDriverState();
}

class _SMSDriverState extends State<SMSDriver> {

  bool pressed = false;

  void changePressedValue() {
    setState(() {
      pressed = !pressed;
    });
  }

  Future<void> onTap() async {
    changePressedValue();
    Timer(const Duration(milliseconds: 450), () {
      if(Platform.isAndroid) {
        const uri = 'sms:+38762923491?body=hello%20there';
        launch(uri);
      }
      else if(Platform.isIOS) {
        const uri = 'sms:+38762923491&body=hello%20there';
        launch(uri);
      }
      changePressedValue();
    }
    );
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
              Icon(Icons.sms_outlined),
              SizedBox(width: 20,),
              Text('SMS message', style: TextStyle(fontSize: 20),)
            ],
          ),
        )
      ),
    );
  }
}
