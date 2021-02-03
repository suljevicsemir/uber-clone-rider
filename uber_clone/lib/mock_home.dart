import 'package:flutter/material.dart';

class HomeMock extends StatefulWidget {
  @override
  _HomeMockState createState() => _HomeMockState();
}

class _HomeMockState extends State<HomeMock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Mock Home'),
        centerTitle: true,
      ),
      body: Center(



        child: Text('Hello'),
      ),
    );
  }
}
