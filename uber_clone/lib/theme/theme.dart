import 'package:flutter/material.dart';

class AppTheme extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {

    return Theme(
      data: ThemeData(

      ),
    );
  }

  static ThemeData appTheme() {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(top: 10, bottom: 12))
        )
      ),
      textTheme: TextTheme(


      )
    );
  }






}
