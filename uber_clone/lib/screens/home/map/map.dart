
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/home_provider.dart';

class HomeMap extends StatefulWidget {
  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {

  Completer<GoogleMapController> mapController = Completer();


  String? mapStyle;
  Marker? marker;
  Circle? circle;
  LocationData? lastLocation;
  CameraPosition? initialCameraPosition;


  Location tracker = Location();



  Future<void> updateMarkerAndCircle(LocationData data) async{
    print('update called');
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
        icon: BitmapDescriptor.defaultMarker
      );
      circle = Circle(
        circleId: CircleId("car"),
        radius: data.accuracy!,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latLng,
        fillColor: Colors.blue.withAlpha(70)
      );
    });
  }






  @override
  void initState() {
    super.initState();
    getCurrentLocation();

    tracker.onLocationChanged.listen((LocationData? data) async{
      if(data == null)
        return;

      if(lastLocation == null)
        return;

      if(geolocator.Geolocator.distanceBetween(lastLocation!.latitude!, lastLocation!.longitude!, data.latitude!, data.longitude!) < 5)
        return;
      print('pomjerilo se');
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
      setState(() {
        mapStyle = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    if( marker == null || circle == null || initialCameraPosition == null || mapStyle == null) {
      return Container(
        color: Colors.amberAccent,
      );
    }


    return GoogleMap(
      onTap: (LatLng latLng) => Provider.of<HomeProvider>(context, listen: false).updateOverlay(),
      initialCameraPosition: initialCameraPosition!,
      onMapCreated: (GoogleMapController controller) async{
        controller.setMapStyle(mapStyle);
        mapController.complete(controller);
      },
      zoomControlsEnabled: false,
      markers: Set.of([marker!]),
      circles: Set.of([circle!])
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
