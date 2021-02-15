import 'dart:async';

import 'package:flutter/material.dart';

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
    // TODO call number
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
