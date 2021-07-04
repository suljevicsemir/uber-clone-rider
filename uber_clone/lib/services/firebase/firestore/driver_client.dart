


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/models/firestore_result.dart';
import 'package:uber_clone/services/firebase/firestore/firestore_client.dart';

class DriverClient extends FirestoreClient {

  DriverClient() : super();

  Future<FirestoreResult> getDriver({required String driverId}) async {

    try {
      DocumentSnapshot snapshot = await driversReference.doc(driverId).get().timeout(const Duration(seconds: 3));
      return FirestoreResult(value: snapshot);
    }
    on TimeoutException catch (value) {
      return FirestoreResult(value: value);
    }
    on Exception catch(value) {
      return FirestoreResult(value: value);
    }

  }

  // method that sends a direct ride request to a driver

  /*Future<FirestoreResult> sendDirectRequest() async {
    try {

    }
    on TimeoutException catch (value) {
      return FirestoreResult(value: value);
    }
    on Exception catch (value) {
      return FirestoreResult(value: value);
    }
  }*/


}