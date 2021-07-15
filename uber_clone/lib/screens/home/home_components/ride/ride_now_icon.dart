

import 'dart:math' as math;

import 'package:flutter/material.dart';
class RideNowIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 130,
      right: 25,
      child: Transform.rotate(
          angle: math.pi / 4,
          child: Image.asset('assets/images/white_car.png', scale: 9.5,)
      ),
    );
  }
}
