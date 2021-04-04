import 'package:flutter/material.dart';

class AppTheme extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {

    return Theme(
      data: ThemeData(

      ),
      child: Container(),
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


        //headline 1 is used for chat tile last message and time
        headline1: TextStyle(
          color: Colors.grey[800],
          fontSize: 17,
          fontWeight: FontWeight.w300
        ),


        //headline2 is used for chat tile names
        headline2: TextStyle(
          color: Colors.grey[800],
          fontSize: 19,
          fontWeight: FontWeight.w400
        ),


        /*headline3 is used in Account Settings screen
        it's used for options title
        for instance 'Manage trusted contacts */

        headline3: TextStyle(
          fontSize: 17,
          color: Colors.black
        ),

        /*headline4 is used in Account Settings screen
        it's used for description of options
        for instance description of 'Privacy' or 'Security' options*/
        headline4: TextStyle(
          color: Colors.grey,
          fontSize: 15
        ),

        //TODO add usage comments
        headline5: TextStyle(
          color: Colors.grey[600],
          fontSize: 19
        ),

        //TODO add usage comments
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w300,
          //fontFamily: ''
        )

      ),
      appBarTheme: AppBarTheme(
        color: Colors.black,
        centerTitle: false,
        elevation: 0.0,
        brightness: Brightness.dark
      ),
    );
  }






}
