import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/constants/driver.dart' as fields;
import 'package:uber_clone/models/chat_info.dart';

class Driver{

  Map<String, int>? rating = {};
  int? numberOfTrips;
  bool? status;
  Timestamp? dateOfStart;
  List<String>? languages = [];
  String? profilePictureUrl;
  String? car;
  String? registrationPlates;

  late String id,
      firstName,
      lastName,
      email,
      phoneNumber,
      from;

  Driver({
    required this.rating,
    required this.numberOfTrips,
    required this.status,
    required this.dateOfStart,
    required this.languages,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.from,
    required this.profilePictureUrl,
    required this.car,
    required this.registrationPlates
  });

  factory Driver.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, int> rating = {};
    List<String> languages = [];
    snapshot.get(fields.rating).forEach((key, value) {
      rating[key] = value;
    });
    snapshot.get(fields.language).forEach((element) {
      languages.add(element);
    });

    return Driver(
      id: snapshot.id,
      rating: rating,
      numberOfTrips: snapshot.get(fields.numberOfTrips),
      status: true,
      dateOfStart: snapshot.get(fields.dateOfStart),
      languages: languages,
      firstName: snapshot.get(fields.firstName),
      lastName: snapshot.get(fields.lastName),
      email: snapshot.get(fields.email),
      phoneNumber: snapshot.get(fields.phoneNumber),
      from: snapshot.get(fields.from),
      profilePictureUrl: snapshot.get("profilePictureUrl"),
      car: snapshot.get("car"),
      registrationPlates: snapshot.get("registrationPlates")

    );
  }

  Driver.fromChatInfo(ChatInfo chatInfo) {
    id = chatInfo.firebaseUserId;
    firstName = chatInfo.firstName;
    lastName = chatInfo.lastName;
    phoneNumber = chatInfo.phoneNumber;

  }


  ///method that calculates time driver's time in service
  ///format displays a message that can be either "days", "months" or "years"
  ///that adds appropriate number of days, months or years

  Map<String, String> timeInService() {
    final Duration duration = DateTime.now().difference(dateOfStart!.toDate());
    Map<String, String> map = {};

    if( duration.inSeconds < 86400 * 30) {
      map["timeSubtitle"] = "Days";
      map["time"] = (duration.inSeconds ~/ 86400).toString();
    }
    else if( duration.inSeconds < 86400 * 30 * 12) {
      map["timeSubtitle"] = "Months";
      map["time"] =  (duration.inSeconds ~/ (86400 * 30)).toString();
    }
    else {

      int years = (duration.inSeconds / (86400 * 365)).truncate();
      double months = (duration.inSeconds - (years * 365 * 86400)) / (30 * 86400);
      map["timeSubtitle"] = "Years";
      map["time"] =  (years + months / 12).toStringAsFixed(1);
    }

    return map;


  }

  String tripsToString() {

    if( numberOfTrips == null)
      return "0";

    String convertedTrips = "";
    int number = numberOfTrips as int;
    if( number > 1000) {
      convertedTrips = convertedTrips + (number ~/ 1000).toString() + ",";
    }

    return convertedTrips + (number % 1000).toString();

  }








}