import 'dart:math' as math;

import 'package:flutter/material.dart';
class RideNow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Positioned(
      bottom: 0.2 * MediaQuery.of(context).size.height,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 0.2 * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: const Color(0xff286ef0),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )
        ),
        child: Container(
          margin: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Ready when you are", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 1.0),),
              Text('Here to help you move safely in the new every day', style: TextStyle(color: Colors.white, fontSize: 16)),
              Row(
                children: [
                  Text('Ride now', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400)),
                  Transform.rotate(
                    angle: math.pi,
                    child: BackButton(onPressed: () {}, color: Colors.white,),
                  )
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
