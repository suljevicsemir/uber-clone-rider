import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/constants/user_settings/ride_verification.dart' as fields;
class RideVerificationProvider extends ChangeNotifier {

  bool _isUserUsingPIN = false, _isNightTimeOnly = false;
  bool _initialUsingPIN = false, _initialNightTime = false;
  String _userId = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore _instance = FirebaseFirestore.instance;
  RideVerificationProvider() {
    _loadVerificationSettings();
  }
  
  
  Future<void> _loadVerificationSettings() async {
    print(_userId);
    DocumentSnapshot rideVerificationSettings = await FirebaseFirestore.instance.collection('user_settings').doc(_userId).get();

      print(rideVerificationSettings.data().toString());
    _isUserUsingPIN = _initialUsingPIN = rideVerificationSettings.get(fields.isUserUsingPIN);


    if( _isUserUsingPIN) {
      _isNightTimeOnly = _initialNightTime = rideVerificationSettings.get(fields.isNightTimeOnly);
    }
    notifyListeners();
  }


  Future<void> updateVerification() async {

   if(!_shouldUpdate())
     return;
    print('updateovat ce');
   await _instance.runTransaction((transaction) async {
      transaction.update(FirebaseFirestore.instance.collection('user_settings').doc(_userId), {
        fields.isUserUsingPIN  : _isUserUsingPIN,
        fields.isNightTimeOnly : _isNightTimeOnly
      });
    });
  }

  bool _shouldUpdate() {

    return isUserUsingPIN != _initialUsingPIN || isNightTimeOnly != _initialNightTime;
  }

  bool get isNightTimeOnly => _isNightTimeOnly;

  bool get isUserUsingPIN => _isUserUsingPIN;

  set isNightTimeOnly(value) {
    _isNightTimeOnly = value;
    notifyListeners();
  }

  set isUserUsingPIN(bool value) {
    _isUserUsingPIN = value;
    notifyListeners();
  }

  bool get initialNightTime => _initialNightTime;

  bool get initialUsingPIN => _initialUsingPIN;
}