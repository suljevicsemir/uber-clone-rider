import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uber_clone/components/app_utils.dart' as app;
class CallDriver extends StatefulWidget {

  final String phoneNumber;


  CallDriver({required this.phoneNumber});

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
          await app.callNumber(context, phoneNumber: widget.phoneNumber);
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
              children: [
                Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 20,),
                    Text('Call driver', style: TextStyle(fontSize: 20),)
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
