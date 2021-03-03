import 'package:flutter/cupertino.dart';
import 'package:uber_clone/models/ride_verification.dart';
import 'package:uber_clone/services/firebase/ride_verification_service.dart';

class RideVerificationProvider extends ChangeNotifier {

  RideVerification _rideVerification = RideVerification();
  final UserSettingsService _settingsService = UserSettingsService();

  RideVerificationProvider() {
    _loadVerificationSettings();
  }
  
  Future<void> _loadVerificationSettings() async {
    _rideVerification = await _settingsService.loadVerificationSettings();
    notifyListeners();
  }

  Future<void> updateVerification() async {
   if(!_shouldUpdate())
     return;

   await _settingsService.updateRideVerification(isUserUsingPIN: _rideVerification.isUserUsingPIN, isNightTimeOnly: _rideVerification.isNightTimeOnly);
  }

  bool _shouldUpdate() {
    return _rideVerification.isUserUsingPIN != _rideVerification.initialUsingPIN || _rideVerification.isNightTimeOnly != _rideVerification.initialNightTime;
  }

  UserSettingsService get settingsService => _settingsService;

  RideVerification get rideVerification => _rideVerification;
}