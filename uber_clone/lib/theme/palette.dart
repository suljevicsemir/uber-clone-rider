import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Palette {


  static final Color dropdownGrey = const Color(0xff545454);


  static final ButtonStyle greyElevatedStyleLeftPadding = ElevatedButton.styleFrom(
      primary: Colors.grey[50],
      elevation: 0,
      onPrimary: Colors.black,
      minimumSize: Size(double.infinity, 40),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20)
  );

  static final ButtonStyle greyElevatedStyleAllPadding = ElevatedButton.styleFrom(
      primary: Colors.grey[50],
      elevation: 0,
      onPrimary: Colors.black,
      minimumSize: Size(double.infinity, 40),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10)
  );


}