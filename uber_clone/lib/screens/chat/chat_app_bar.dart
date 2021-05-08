

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/app_utils.dart' as app;
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/providers/profile_pictures_provider.dart';
import 'package:uber_clone/screens/driver_profile/driver_profile.dart';

@immutable
class ChatAppBar extends StatelessWidget {

  final Driver driver;

  const ChatAppBar({required this.driver});



  @override
  Widget build(BuildContext context) {

    File? picture = Provider.of<ProfilePicturesProvider>(context, listen: false).driverProfilePictures![driver.id];

    return AppBar(
      elevation: 0.0,
      title: GestureDetector(
        onTap: () async => await Navigator.pushNamed(context, DriverProfile.route, arguments: driver.id),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 17,
              backgroundImage: FileImage(picture!),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(width: 10,),
            Text(driver.firstName)
          ],
        ),
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.only(right: 10),
          onPressed: () async => app.callNumber(context, phoneNumber: driver.phoneNumber),
          icon: const Icon(Icons.call),
        )
      ],
    );
  }
}

