import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Container(
                    height: 400,
                    width: 400,
                      child: Image.asset('assets/images/driver_rider_mask.png', fit: BoxFit.cover,)))
            ],
          ),
        ),
      ),
    );
  }
}
