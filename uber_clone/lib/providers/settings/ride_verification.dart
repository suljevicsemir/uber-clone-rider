import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/constants/user_settings/ride_verification.dart' as fields;
import 'package:uber_clone/services/firebase/firestore/firestore_service.dart';
import 'package:uber_clone/services/firebase/ride_verification_service.dart';
class RideVerificationProvider extends ChangeNotifier {


  bool _isUserUsingPIN = false, _isNightTimeOnly = false;
  bool _initialUsingPIN = false, _initialNightTime = false;
  final UserSettingsService _settingsService = UserSettingsService();

  RideVerificationProvider() {
    _loadVerificationSettings();
  }
  
  Future<void> _loadVerificationSettings() async {
    DocumentSnapshot snapshot = await FirestoreService.userSettings.get();
    _isUserUsingPIN  = _initialUsingPIN  = snapshot.get(fields.isUserUsingPIN);

    if(_isUserUsingPIN) {
      _isNightTimeOnly = _initialNightTime = snapshot.get(fields.isNightTimeOnly);
    }
    notifyListeners();
  }

  Future<void> updateVerification() async {
   if(!_shouldUpdate())
     return;
  print('it will update');
   await _settingsService.updateRideVerification(isUserUsingPIN: _isUserUsingPIN, isNightTimeOnly: _isNightTimeOnly);
  }

  bool _shouldUpdate() {
    return _isUserUsingPIN != _initialUsingPIN || _isNightTimeOnly != _initialNightTime;
  }

  get isNightTimeOnly => _isNightTimeOnly;

  set isNightTimeOnly(value) {
    _isNightTimeOnly = value;
    print('updateovo se night time only ' + value.toString());
    notifyListeners();
  }

  bool get isUserUsingPIN => _isUserUsingPIN;

  set isUserUsingPIN(bool value) {
    _isUserUsingPIN = value;
    print('updateovo se koristi pin ' + value.toString());
    notifyListeners();
  }
}