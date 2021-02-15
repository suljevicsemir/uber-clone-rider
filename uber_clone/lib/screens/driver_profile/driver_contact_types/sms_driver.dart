import 'dart:async';

import 'package:flutter/material.dart';
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
    // TODO open sms messenger
  }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changePressedValue,
      onLongPress: () async{
        changePressedValue();
        Timer(const Duration(milliseconds: 450), () => changePressedValue());
      },
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
