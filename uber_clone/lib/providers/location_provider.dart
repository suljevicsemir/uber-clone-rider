
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class LocationProvider extends ChangeNotifier{

  Location _location = Location();
  LatLng? _firstLocation;
  bool _mapReady = false;

 // late StreamSubscription<QuerySnapshot> driversListener;



  LocationProvider() {
    _startLocationListener();
  }

  void _startLocationListener() {
    _location.onLocationChanged.listen((LocationData locationData) {
      if( _firstLocation == null) {
        _firstLocation = LatLng(locationData.latitude!, locationData.longitude!);
        _mapReady = true;
        notifyListeners();
      }
    });
  }

  /*void pauseDriverStream() {
    driversListener.pause();
  }*/

  /*void resumeDriverStream() {
    if(driversListener.isPaused) {
      print('resuming driver listener');
      driversListener.resume();
      notifyListeners();
    }
  }*/

  @override
  void dispose() {
    super.dispose();
    print('Disposing LocationProvider');
    //driversListener.cancel().then((value) => print('drivers listener disposed'));
  }

  bool get mapReady => _mapReady;
  LatLng? get lastLocation => _firstLocation;

}