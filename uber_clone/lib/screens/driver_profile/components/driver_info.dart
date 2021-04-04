

import 'package:flutter/material.dart';

class DriverInfo extends StatelessWidget {

  final String shortDescription, from;

  DriverInfo({required this.shortDescription, required this.from});



  final TextStyle greyText = TextStyle(
    fontSize: 18,
    color: const Color(0xff8f8f95),
  );

  final TextStyle boldText = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 16
  );


  @override
  Widget build(BuildContext context) {

    String city = from.split(',')[0];
    String country = from.split(',')[1];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15,),
        Text(shortDescription, style: greyText,),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(
              text: 'Knows ',
              style: greyText,
              children: [
                TextSpan(
                    text: 'English',
                    style: boldText
                ),
                TextSpan(
                    text: ' Italian',
                    style: boldText
                ),
                TextSpan(
                    text: ' German',
                    style: boldText
                )
              ]
          ),
        ),
        SizedBox(height: 10,),
        RichText(
          text: TextSpan(
              text: 'From ',
              style: greyText,
              children: [
                TextSpan(
                    text:  city + ', ',
                    style: boldText
                ),
                TextSpan(
                    text:  country,
                    style: boldText
                ),
              ]
          ),
        ),
      ],
    );
  }
}