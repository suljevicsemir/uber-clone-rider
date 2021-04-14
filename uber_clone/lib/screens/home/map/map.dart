
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/models/custom_marker_id.dart';
import 'package:uber_clone/providers/home_provider.dart';

class HomeMap extends StatefulWidget {
  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {

  Completer<GoogleMapController> mapController = Completer();
  String? mapStyle;
  Marker? marker;
  LocationData? lastLocation;
  CameraPosition? initialCameraPosition;
  Uint8List? imageData;
  Location tracker = Location();
  Set<Marker> markers = Set<Marker>();
  Set<CustomMarkerId> markerIds = Set<CustomMarkerId>();

  Uint8List? whiteCar, redCar;

  Future<void> updateMarkerAndCircle(LocationData data) async{
    LatLng latLng = LatLng(data.latitude!, data.longitude!);
    setState(() {
      marker = Marker(
        markerId: MarkerId("home"),
        position: latLng,
        rotation: data.heading!,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData!),
        onTap: () {}
      );
    });
  }

  dynamic x;

  @override
  void initState() {
    super.initState();



    tracker.onLocationChanged.listen((LocationData? data) async{
      if(data == null || lastLocation == null)
        return;

      if(geolocator.Geolocator.distanceBetween(lastLocation!.latitude!, lastLocation!.longitude!, data.latitude!, data.longitude!) < 5)
        return;

      lastLocation = data;
        await mapController.future.then((GoogleMapController controller) async {
          if(data.longitude == null || data.latitude == null )
            return;
          double zoomLevel = await controller.getZoomLevel();
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: 0,
              target: LatLng(data.latitude!, data.longitude!),
              tilt: 0,
              zoom: zoomLevel
            )
          ));
          updateMarkerAndCircle(data);
        });
    });

  }

  Future<void> getCurrentLocation() async {
    await tracker.changeSettings(accuracy: LocationAccuracy.navigation);
    LocationData data = await tracker.getLocation();
    setState(() {
      initialCameraPosition = CameraPosition(
          target: LatLng(data.latitude!, data.longitude!),
          zoom: 15
      );
      lastLocation = data;
    });
    updateMarkerAndCircle(data);
  }

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async{
      String value = await DefaultAssetBundle.of(context).loadString('assets/map/style.json');
      //ByteData byteData = await DefaultAssetBundle.of(context).load('assets/images/location.png');
      ByteData whiteCarData = await DefaultAssetBundle.of(context).load('assets/images/white_car.png');
      ByteData redCarData = await DefaultAssetBundle.of(context).load('assets/images/red_car.png');

      ui.Codec whiteCarCodec = await ui.instantiateImageCodec(whiteCarData.buffer.asUint8List(), targetWidth: 120, targetHeight: 90);
      ui.Codec redCarCodec = await ui.instantiateImageCodec(redCarData.buffer.asUint8List(), targetWidth: 120, targetHeight: 110);

      ui.FrameInfo whiteCarFrameInfo = await whiteCarCodec.getNextFrame();
      ui.FrameInfo redCarFrameInfo = await redCarCodec.getNextFrame();

      Uint8List whiteCarList = (await whiteCarFrameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
      Uint8List redCarList = (await redCarFrameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();


      //ui.Codec codec = await ui.instantiateImageCodec(byteData.buffer.asUint8List(), targetWidth: 60, targetHeight: 120);
      //ui.FrameInfo fi = await codec.getNextFrame();
      //Uint8List list =  (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

      setState(() {
        mapStyle = value;
        whiteCar = whiteCarList;
        redCar = redCarList;

      });

      x = FirebaseFirestore.instance.collection('driver_locations').snapshots().listen((QuerySnapshot snapshot) {
        List<QueryDocumentSnapshot> list = snapshot.docs;
        list.forEach((QueryDocumentSnapshot documentSnapshot) {
          GeoPoint geoPoint = documentSnapshot.get('location');
          bool markerExists = markerIds.contains(CustomMarkerId(id: documentSnapshot.id));
          if(markerExists) {
            markers.removeWhere((Marker marker) => marker.markerId.value == documentSnapshot.id);
          }
          bool isRed = false;
          if(documentSnapshot.get('carColor') == 'red')
            isRed = true;
          setState(() {
            markers.add(Marker(
                markerId: MarkerId(documentSnapshot.id),
                position: LatLng(geoPoint.latitude, geoPoint.longitude),
                draggable: false,
                zIndex: 2,
                flat: true,
                anchor: Offset(0.5, 0.5),
                icon: isRed ? BitmapDescriptor.fromBytes(redCar!) : BitmapDescriptor.fromBytes(whiteCar!)
            ));
            markerIds.add(CustomMarkerId(id: documentSnapshot.id));
          });
        });
      });
      /*fi.image.toByteData(format: ui.ImageByteFormat.png).then((ByteData? byteData) {
        setState(() {
          mapStyle = value;
          imageData = byteData!.buffer.asUint8List();
        });
        getCurrentLocation();
      });*/

    });
  }


  final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(43.796705, 18.092931),
    zoom: 15
  );


  @override
  Widget build(BuildContext context) {

    if( /*marker == null || */ /*initialCameraPosition == null || */ mapStyle == null /*|| imageData == null*/) {
      return Container(
        color: Colors.amberAccent,
      );
    }


    return GoogleMap(
      onTap: (LatLng latLng) => Provider.of<HomeProvider>(context, listen: false).updateOverlay(),
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController controller) async{
        controller.setMapStyle(mapStyle);
        mapController.complete(controller);
      },
      zoomControlsEnabled: false,
      markers: markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
    );
  }

  Future<void> disposeController() async {
    await mapController.future.then((value) => value.dispose());
  }

  @override
  void dispose() {
    super.dispose();
    disposeController();
    x.cancel();
  }
}
