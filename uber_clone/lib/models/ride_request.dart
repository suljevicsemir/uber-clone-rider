import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/components/app_utils.dart' as app;
import 'package:uber_clone/constants/ride_request.dart' as fields;
import 'package:uber_clone/services/firebase/firebase_service.dart';

@immutable
class RideRequest{

  final String riderId, token;
  final Timestamp timestamp, startInterval, endInterval;
  final GeoPoint location, destination;

  RideRequest({
    required this.riderId,
    required this.timestamp,
    required this.startInterval,
    required this.endInterval,
    required this.location,
    required this.destination,
    required this.token
  });

  factory RideRequest.fromMap(Map<String, dynamic> map) {

    DateTime dateTime = map['dateTime'] as DateTime;
    GeoPoint location = map['location'] as GeoPoint, destination = map['destination'] as GeoPoint;
    String token = map['token'];

    return RideRequest(
      riderId: FirebaseService.id,
      timestamp: Timestamp.now(),
      startInterval: Timestamp.fromDate(dateTime),
      endInterval: Timestamp.fromDate(dateTime.add(const Duration(minutes: 10))),
      location: GeoPoint(location.latitude , location.longitude),
      destination: GeoPoint(destination.latitude, destination.longitude),
      token: token
    );
  }




  Future<void> sendRequest() async {
    DateTime dateTime = DateTime.now();
    print(app.getMonth(dateTime));
    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      FirebaseFirestore.instance.collection('ride_requests')
          .add(_toMap());
    });
  }



  Map<String, dynamic> _toMap() {
    return {
      fields.riderId       : this.riderId,
      fields.timestamp     : this.timestamp,
      fields.location      : this.location,
      fields.destination   : this.destination,
      fields.endInterval   : this.endInterval,
      fields.startInterval : this.startInterval,
      fields.token         : this.token
    };
  }

  @override
  String toString() {
    return "Rider id: $riderId\n" + "timestamp: $timestamp\n" +
    "location: $location\n" + "destination:$destination\n" + "endInterval: $endInterval\n" +
    "startInterval: $startInterval\n" + "token: $token";
  }
}