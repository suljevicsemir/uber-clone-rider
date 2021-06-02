import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/app_utils.dart' as app;
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/models/message.dart';
import 'package:uber_clone/providers/profile_pictures_provider.dart';
import 'package:uber_clone/screens/driver_profile/driver_profile.dart';
import 'package:uber_clone/services/firebase/firebase_service.dart';

class ReceivedMessage extends StatelessWidget {


  const ReceivedMessage({
    required this.message,
    required this.nextMessage,
    required this.isLast,
    required this.driver
  });

  final Message message;
  final Message? nextMessage;
  final bool isLast;
  final Driver driver;




  @override
  Widget build(BuildContext context) {

    bool isNextSent = false;
    if( nextMessage != null) {
      isNextSent = nextMessage!.firebaseUserId == FirebaseService.id;
    }
    bool shouldHavePicture = isNextSent || isLast;

    File? picture = Provider.of<ProfilePicturesProvider>(context, listen: false).driverProfilePictures![driver.id];


    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        shouldHavePicture ? GestureDetector(
         onTap: () async => Navigator.pushNamed(context, DriverProfile.route, arguments: driver),
         child: Container(
           margin: const EdgeInsets.only(left: 5),
           child:  CircleAvatar(
             radius: 13,
             backgroundColor: Colors.transparent,
             backgroundImage:  FileImage(picture!),
           ),
         ),
        ) :
        Container(),
        Container(
          padding: EdgeInsets.all(10),
          margin: shouldHavePicture ? EdgeInsets.only(bottom: 10, left: 7) :  EdgeInsets.only(left: 39 , bottom: 10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20)
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7
          ),
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Text(message.message, style: TextStyle(color: Colors.black, fontSize: 16),),
              SizedBox(width: 10,),
              Text(app.formatMessageTime(message.timestamp), style: TextStyle(fontSize: 12),)
            ],
          )
        )
      ],
    );
  }
}
