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

        headline5: TextStyle(
          color: Colors.grey[600],
          fontSize: 18
        ),
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontFamily: 'BenneRegular'
        )

      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        //color: Colors.white,
        centerTitle: false,
        elevation: 0.0,
        brightness: Brightness.dark
      ),
    );
  }






}
