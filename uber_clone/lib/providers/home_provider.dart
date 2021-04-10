


import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeProvider extends ChangeNotifier{

  bool _isOverlayShown = true;
  String? mapStyle;
  LocationData? lastLocation;
  CameraPosition? cameraPosition;
  CameraPosition? initialCameraPosition;
  bool _hasPermission = false;
  Location locationTracker = Location();


  HomeProvider() {

  }

  Future<void> _checkPermission() async {
    if((await locationTracker.hasPermission()) == PermissionStatus.denied) {
      locationTracker.requestPermission();
    }
  }


  void updateOverlay() {
    _isOverlayShown = !_isOverlayShown;
    notifyListeners();
  }


  Future<LocationData> getCurrentLocation() async {
    LocationData data = await locationTracker.getLocation();
    return await locationTracker.getLocation();
  }

  Future<CameraPosition> getInitialCameraPosition() async {
    LocationData data = await locationTracker.getLocation();

    return CameraPosition(
      target: LatLng(data.latitude!, data.longitude!),
      zoom: 15
    );
  }




  bool get isOverlayShown => _isOverlayShown;

}