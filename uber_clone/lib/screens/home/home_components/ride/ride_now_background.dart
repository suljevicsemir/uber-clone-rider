

import 'package:flutter/material.dart';

class RideNowBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 220,
        decoration: BoxDecoration(
            color: const Color(0xff286ef0),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(150)
            )
        ),
      ),
    );
  }
}
