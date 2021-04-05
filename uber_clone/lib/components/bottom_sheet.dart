

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/profile_pictures_provider.dart';

class BottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: EdgeInsets.only(top: 10),
      child:  Container(
        margin: const EdgeInsets.only(left: 10, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Edit profile photo', style: const TextStyle(fontSize: 20, color: Colors.black54,)),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () async => await Provider.of<ProfilePicturesProvider>(context, listen: false).pickImageFromSource(ImageSource.gallery),
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Container(
                        color: Colors.green,
                        child:  SizedBox(
                          height: 40,
                          width: 40,
                          child: const Icon(Icons.photo, color: Colors.white,),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    const Text('Gallery', style: const TextStyle(fontSize: 19, color: Colors.black87),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () async => await Provider.of<ProfilePicturesProvider>(context, listen: false).pickImageFromSource(ImageSource.camera),
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Container(
                        color: Colors.blueGrey,
                        child:  SizedBox(
                          height: 40,
                          width: 40,
                          child: const Icon(Icons.camera_alt, color: Colors.white,),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    const Text('Camera', style: const TextStyle(fontSize: 19, color: Colors.black87),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}