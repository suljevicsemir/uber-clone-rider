import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

   Future<void> callNumber(BuildContext context, {required String phoneNumber}) async{
    if(await canLaunch("tel://" + phoneNumber))
      launch("tel://" + phoneNumber);
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Unable to dial!', style: TextStyle(fontSize: 18, color: Colors.black87),),
          )
      );
    }
  }

   Future<void> sendSMS(BuildContext context, {required String phoneNumber}) async {
    if(await canLaunch('sms:' + phoneNumber)) {
      launch('sms:' + phoneNumber);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text('Problem opening messaging app'))
      );
    }

  }


  SnackBar connectivityOnlineSnackBar() {
    return SnackBar(
      padding: EdgeInsets.zero,
      duration: const Duration(seconds: 2),
      backgroundColor: const Color(0xff2C2f33),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You are back online!', style: TextStyle(fontSize: 18, color: Colors.white)),
        ],
      ),
    );
  }

  Row connectivityOfflineBanner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 5,
          width: 3,
          color: Colors.red,
        ),
        SizedBox(width: 1,),
        Container(
          color: const Color(0xff23272A),
          child: SizedBox(
            height: 8,
            width: 3,
          ),
        ),
        SizedBox(width: 1,),
        Container(
          color: const Color(0xff23272A),
          child: SizedBox(
            height: 11,
            width: 3,
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('Network connectivity limited or unavailable.', style: TextStyle(fontSize: 18),)
          ),
        )
      ],
    );
  }

  String formatMessageTime(Timestamp timestamp) {
     int hour = timestamp.toDate().hour, minute = timestamp.toDate().minute;

     String result = "";
     if( hour < 10)
       result = result + "0";
    result = result + hour.toString() + ":";

    if( minute < 10)
      result = result + "0";

    return result + minute.toString();

  }