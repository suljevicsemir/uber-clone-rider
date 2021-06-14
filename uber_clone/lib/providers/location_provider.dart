import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uber_clone/screens/home/home_components/driver_bottom_sheet/driver_bottom_sheet.dart';


class LocationProvider extends ChangeNotifier{

  final BuildContext context;
  Location _location = Location();
  LatLng? _firstLocation;
  Completer<GoogleMapController> mapController = Completer();
  Uint8List? whiteCar, redCar;
  String? mapStyle;
  Set<Marker> markers = Set<Marker>();
  late StreamSubscription<GoogleMapController> locationTracker;
  late StreamSubscription<QuerySnapshot> driversListener;

  bool _didLoadDrivers = false, _mapReady = false;
  int _availableDrivers = 0;

  LocationProvider(this.context) {
    _loadData(context);
  }

  Future<void> _loadData(BuildContext context) async {
    await Future.wait([
      _loadCarImages(context),
      _loadMapStyle(context)
    ]);
    notifyListeners();
    _startLocationListener();
    Future.delayed(const Duration(milliseconds: 300), () => _startDriversListener());
  }

  void _startDriversListener() {

    driversListener = FirebaseFirestore.instance
        .collection('driver_locations')
        .where('status', isEqualTo: true)
        .limit(50)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
            List<DocumentSnapshot> list = querySnapshot.docs;
            markers.clear();

            for(int i = 0; i < list.length; i++) {
              DocumentSnapshot snapshot = list[i];

              markers.add(Marker(
                  markerId: MarkerId(snapshot.id),
                  position: LatLng( snapshot.get('location').latitude, snapshot.get('location').longitude),
                  draggable: false,
                  zIndex: 2,
                  rotation: snapshot.get('heading'),
                  anchor: Offset(0.5, 0.5),
                  icon: snapshot.get("carColor") == 'red' ? BitmapDescriptor.fromBytes(redCar!) : BitmapDescriptor.fromBytes(whiteCar!),
                  onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context ) => DriverBottomSheet(driverId: snapshot.id))
              ));
            }
            _availableDrivers = markers.length;
            notifyListeners();
        });

    _didLoadDrivers = true;
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

  Future<void> _loadCarImages(BuildContext context) async {

    ByteData whiteCarData = await DefaultAssetBundle.of(context).load('assets/images/white_car.png');
    ByteData redCarData = await DefaultAssetBundle.of(context).load('assets/images/red_car.png');

    ui.Codec whiteCarCodec = await ui.instantiateImageCodec(whiteCarData.buffer.asUint8List(), targetWidth: 120, targetHeight: 70);
    ui.Codec redCarCodec = await ui.instantiateImageCodec(redCarData.buffer.asUint8List(), targetWidth: 120, targetHeight: 110);

    ui.FrameInfo whiteCarFrameInfo = await whiteCarCodec.getNextFrame();
    ui.FrameInfo redCarFrameInfo = await redCarCodec.getNextFrame();

    Uint8List whiteCarList = (await whiteCarFrameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
    Uint8List redCarList = (await redCarFrameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

    whiteCar = whiteCarList;
    redCar = redCarList;
  }

  Future<void> _loadMapStyle(BuildContext context) async {
    mapStyle = await DefaultAssetBundle.of(context).loadString('assets/map/style.json');
  }

  void pauseDriverStream() {
    driversListener.pause();
  }
  void resumeDriverStream() {
    if(driversListener.isPaused) {
      print('resuming driver listener');
      driversListener.resume();
      notifyListeners();
    }
  }


  @override
  void dispose() {
    super.dispose();
    print('Disposing LocationProvider');
    locationTracker.cancel().then((value) => print('location tracker disposed'));
    driversListener.cancel().then((value) => print('drivers listener disposed'));
  }

  bool get didLoadDrivers => _didLoadDrivers;
  bool get mapReady => _mapReady;

  int get availableDrivers => _availableDrivers;

  LatLng? get lastLocation => _firstLocation;

}