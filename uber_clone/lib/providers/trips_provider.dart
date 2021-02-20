import 'package:flutter/cupertino.dart';

enum TripType {
  Past,
  Business,
  Upcoming
}

extension tripTypeToString on TripType {
  String parseTripType() {
    return this.toString().split(".").last;
  }

  int typeToIndex() {
    if(this == TripType.Past)
      return 0;
    if( this == TripType.Upcoming)
      return 1;
    return 2;

  }
}

class TripsProvider extends ChangeNotifier{
  bool _shown = false;
  TripType _tripType = TripType.Past;


  bool get shown => _shown;

  void changeShown() {
    _shown = !_shown;
    notifyListeners();
  }

  set shown(bool value) {
    _shown = value;
    notifyListeners();
  }

  TripType get tripType => _tripType;

  set tripType(TripType value) {
    _tripType = value;
    notifyListeners();
  }
}