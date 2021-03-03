import 'package:flutter/cupertino.dart';

class RideVerification extends ChangeNotifier {
  bool _isUserUsingPIN = false, _isNightTimeOnly = false;
  bool _initialUsingPIN = false, _initialNightTime = false;

  bool get isUserUsingPIN => _isUserUsingPIN;

  set isUserUsingPIN(bool value) {
    _isUserUsingPIN = value;
    notifyListeners();
  }

  get isNightTimeOnly => _isNightTimeOnly;

  get initialNightTime => _initialNightTime;

  set initialNightTime(value) {
    _initialNightTime = value;
    notifyListeners();
  }

  bool get initialUsingPIN => _initialUsingPIN;

  set initialUsingPIN(bool value) {
    _initialUsingPIN = value;
    notifyListeners();
  }

  set isNightTimeOnly(value) {
    _isNightTimeOnly = value;
    notifyListeners();
  }
}