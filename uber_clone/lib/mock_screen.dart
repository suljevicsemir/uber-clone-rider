import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uber_clone/services/cached_data/cached_pictures.dart';

class MockScreen extends StatefulWidget {

  static const route = '/mockScreen';

  @override
  _MockScreenState createState() => _MockScreenState();
}

class _MockScreenState extends State<MockScreen> {

 CachedPicture cachedPicture;


 @override
  void initState() {
   super.initState();
   cachedPicture = CachedPicture();
   _nesto();
  }

  String path;

 Future<void> _nesto() async {
   path = await cachedPicture.getPath();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text('shajdhjkas'),
              path == null ? Container() :
              CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.transparent,
                backgroundImage: FileImage(File('$path/images/prvaSlika.png')),
              )

            ],
          ),
        ),
      ),
    );
  }
}
