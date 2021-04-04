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

