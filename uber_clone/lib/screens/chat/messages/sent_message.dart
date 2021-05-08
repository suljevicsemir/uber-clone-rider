

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/models/message.dart';
import 'package:uber_clone/providers/profile_pictures_provider.dart';
import 'package:uber_clone/screens/driver_profile/driver_profile.dart';
import 'package:uber_clone/services/firebase/firebase_service.dart';

@immutable
 class SentMessage extends StatelessWidget {


  final Message message;
  final Message? nextMessage;
  final bool isLast;
  final Driver driver;
  SentMessage({required this.message, required this.nextMessage, required this.isLast, required this.driver});


  @override
  Widget build(BuildContext context) {




    bool isNextSent = false;
    bool sentMessage = message.firebaseUserId == FirebaseService.id ? true : false;
    if( nextMessage != null) {
      isNextSent = nextMessage!.firebaseUserId == FirebaseService.id;
    }

    bool shouldHavePicture = (isNextSent && !sentMessage) || (isLast && !sentMessage);

    print(message.message);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: sentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        shouldHavePicture ? GestureDetector(
          onTap: () async => Navigator.pushNamed(context, DriverProfile.route, arguments: driver),
          child: Container(
            margin: EdgeInsets.only(left: 3),
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Colors.transparent,
              backgroundImage: FileImage(Provider.of<ProfilePicturesProvider>(context, listen: false).driverProfilePictures![driver.id]!),
            ),
          ),
        ) :
        Container(),
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          margin: (sentMessage) ? EdgeInsets.only(right: 10, bottom: 10) : shouldHavePicture ? EdgeInsets.only(bottom: 10, left: 7) :  EdgeInsets.only(left: 39 , bottom: 10),
          decoration: BoxDecoration(
              color: sentMessage ? const Color(0xffc8e1fd) : Colors.grey[300],
              borderRadius: BorderRadius.circular(20)
          ),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.5
          ),
          child: Text(message.message, style: TextStyle(color: Colors.black, fontSize: 16),),
        ),

      ],
    );
  }
}
