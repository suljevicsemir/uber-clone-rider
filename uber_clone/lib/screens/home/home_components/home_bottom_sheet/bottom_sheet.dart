

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uber_clone/screens/home/home_components/home_bottom_sheet/bottom_sheet_component.dart';
import 'package:uber_clone/screens/home/home_components/home_bottom_sheet/set_pickup.dart';
import 'package:uber_clone/screens/home/home_components/home_bottom_sheet/sheet_separator.dart';

class HomeBottomSheet extends StatelessWidget {

  final DateTime dateTime = DateTime.now();

  String getDay() {
    return DateFormat('EEEE').format(dateTime).substring(0, 3);
  }

  String getMonth() {
    final df = DateFormat('dd-MMM-yyy');
    List<String> array =  df.format(dateTime).split('-');
    return array[1];
  }

  String getDate() {
    return getDay() + ", " + getMonth() + " " + dateTime.day.toString();
  }

  String formatTime(DateTime time) {
    String hour = "", minute = "";
    hour = time.hour < 10 ? ('0' + time.hour.toString()) : time.hour.toString();
    minute = time.minute < 10 ? ('0' + time.minute.toString()) : time.minute.toString();
    return hour + ":" + minute;
  }

  String getTime() {
    DateTime startTime = dateTime.add(const Duration(minutes: 5));
    while((startTime.minute) % 5 != 0) {
      startTime = startTime.add(const Duration(minutes: 1));
    }
    DateTime endTime = startTime.add(const Duration(minutes: 10));
    return formatTime(startTime) + " - " +  formatTime(endTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SheetComponent(content: 'Schedule a ride', isFirst: true,),
          SheetSeparator(hasMargin: false),
          SheetComponent(content: getDate(), isFirst: false,),
          SheetSeparator(hasMargin: true),
          SheetComponent(content: getTime(), isFirst: false,),
          SheetSeparator(hasMargin: false),
          Spacer(),
          SetPickup(),
          Spacer()

        ],
      ),
    );
  }
}
