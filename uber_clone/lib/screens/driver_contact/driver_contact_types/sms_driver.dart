import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uber_clone/components/app_utils.dart' as app;
class SMSDriver extends StatefulWidget {

  final String phoneNumber;


  SMSDriver({required this.phoneNumber});

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

  Future<void> onLongPress() async {
    changePressedValue();
    Timer(const Duration(milliseconds: 450), () => changePressedValue());

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        changePressedValue();
        Timer(const Duration(milliseconds: 200), () async {
          await app.sendSMS(context, phoneNumber: widget.phoneNumber);
          changePressedValue();
        });

      },
      onLongPress: onLongPress,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: 15, left: 5),
        duration: const Duration(milliseconds: 300),
        color: pressed ? Colors.grey : Colors.transparent,
        curve: Curves.fastOutSlowIn,
        child: Container(
          margin: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.sms_outlined),
                  SizedBox(width: 20,),
                  Text('SMS message', style: TextStyle(fontSize: 20),)
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 45, bottom: 5, top: 5),
                width: double.infinity,
                child: Text('Mobile carrier\'s rates apply', style: TextStyle(fontSize: 14, color: Colors.black54),),
              ),
              Container(
                margin: EdgeInsets.only(left: 45, bottom: 5, top: 5),
                height: 1,
                width: double.infinity,
                color: Colors.black26,
              ),
            ],
          )
        )
      ),
    );
  }
}
