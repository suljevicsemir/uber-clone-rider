import 'package:flutter/cupertino.dart';

enum TripTypes {
  Past,
  Business,
  Upcoming
}

class TripsProvider extends ChangeNotifier{

  TripTypes _type = TripTypes.Past;
  bool shown = false;


  void changeShown() {
    shown = !shown;
    print('its called');
    notifyListeners();
  }

  TripTypes get type => _type;
  set type(TripTypes value) {
    _type = value;
    notifyListeners();
  }



  @override
  void dispose() {
    super.dispose();
  }
}