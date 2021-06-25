

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/models/driver.dart';

class FirestoreDriverService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<Driver> getDriver({required String id}) async {
    DocumentSnapshot snapshot = await _instance.collection('drivers').doc(id).get();
    return Driver.fromSnapshot(snapshot);
  }







}