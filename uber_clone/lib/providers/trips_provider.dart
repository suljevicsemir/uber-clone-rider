import 'package:flutter/cupertino.dart';

enum TripType {
  Past,
  Business,
  Upcoming
}

class TripsProvider extends ChangeNotifier{

  TripType _type = TripType.Past;
  bool shown = false;
  TripType tripType = TripType.Past;

  void changeShown() {
    shown = !shown;
    print('its called');
    notifyListeners();
  }

  void changeTripType(TripType tripType) {
    this.tripType = tripType;
    notifyListeners();
  }

  TripType get type => _type;
  set type(TripType value) {
    _type = value;
    notifyListeners();
  }



  @override
  void dispose() {
    super.dispose();
  }
}