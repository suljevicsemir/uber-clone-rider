import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/constants/driver.dart' as fields;
import 'package:uber_clone/models/chat_info.dart';

class Driver{

  Map<String, String>? rating = {};
  int? numberOfTrips;
  bool? status;
  Timestamp? dateOfStart;
  List<String>? languages = [];

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
    required this.from
  });

  factory Driver.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, String> rating = {};
    List<String> languages = [];
    snapshot.get(fields.rating).forEach((key, value) {
      rating[key] = value.toString();
    });
    snapshot.get(fields.language).forEach((element) {
      languages.add(element);
    });

    return Driver(
      id: snapshot.id,
      rating: rating,
      numberOfTrips: snapshot.get(fields.numberOfTrips),
      status: snapshot.get(fields.status),
      dateOfStart: snapshot.get(fields.dateOfStart),
      languages: languages,
      firstName: snapshot.get(fields.firstName),
      lastName: snapshot.get(fields.lastName),
      email: snapshot.get(fields.email),
      phoneNumber: snapshot.get(fields.phoneNumber),
      from: snapshot.get(fields.from)
    );
  }

  Driver.fromChatInfo(ChatInfo chatInfo) {
    id = chatInfo.firebaseUserId;
    firstName = chatInfo.firstName;
    lastName = chatInfo.lastName;
    phoneNumber = chatInfo.phoneNumber;

  }





}