


import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeProvider extends ChangeNotifier{

  bool _isOverlayShown = true;
  String? mapStyle;
  LocationData? lastLocation;
  CameraPosition? cameraPosition;
  CameraPosition? initialCameraPosition;

  Location locationTracker = Location();
  PermissionStatus? _permissionStatus;

  HomeProvider() {
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    _permissionStatus = await locationTracker.hasPermission();
    if(_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await locationTracker.requestPermission();
    }
    notifyListeners();
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

  PermissionStatus? get permissionStatus => _permissionStatus;
}