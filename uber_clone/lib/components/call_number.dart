import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallNumber extends StatelessWidget {
  final String phoneNumber;
  CallNumber({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {

        print(phoneNumber);
        if(await canLaunch("tel://" + phoneNumber)) {
          launch("tel://" + phoneNumber);
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Unable to dial!', style: TextStyle(fontSize: 18, color: Colors.black87),),
              )
          );
        }
      },
      icon: Icon(Icons.call),
    );
  }
}
