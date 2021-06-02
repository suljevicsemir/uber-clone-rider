
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/models/custom_marker_id.dart';
import 'package:uber_clone/providers/home_provider.dart';
import 'package:uber_clone/providers/map_snapshot_provider.dart';
import 'package:uber_clone/screens/home/home_components/driver_bottom_sheet/driver_bottom_sheet.dart';

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

  bool isFirstRun = true;


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

    /*tracker.onLocationChanged.listen((LocationData? data) async{
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
          //updateMarkerAndCircle(data);
        });
    });*/

    getCurrentLocation();

  }

  Future<void> getCurrentLocation() async {
    await tracker.changeSettings(accuracy: LocationAccuracy.navigation);
    LocationData data = await tracker.getLocation();

    _setCurrentData(data);


    //updateMarkerAndCircle(data);
  }

  Future<void> _setCurrentData(LocationData data) async{
    if( this.mounted) {
      setState(() {
        initialCameraPosition = CameraPosition(
            target: LatLng(data.latitude!, data.longitude!),
            zoom: 16
        );
        lastLocation = data;
      });
    }
    else Future.delayed(const Duration(milliseconds: 30), () => {
      _setCurrentData(data)
    });
  }

  late StreamSubscription locations;


  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();

    if( isFirstRun) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async{
        String value = await DefaultAssetBundle.of(context).loadString('assets/map/style.json');

        ByteData whiteCarData = await DefaultAssetBundle.of(context).load('assets/images/white_car.png');
        ByteData redCarData = await DefaultAssetBundle.of(context).load('assets/images/red_car.png');

        ui.Codec whiteCarCodec = await ui.instantiateImageCodec(whiteCarData.buffer.asUint8List(), targetWidth: 120, targetHeight: 90);
        ui.Codec redCarCodec = await ui.instantiateImageCodec(redCarData.buffer.asUint8List(), targetWidth: 120, targetHeight: 110);

        ui.FrameInfo whiteCarFrameInfo = await whiteCarCodec.getNextFrame();
        ui.FrameInfo redCarFrameInfo = await redCarCodec.getNextFrame();

        Uint8List whiteCarList = (await whiteCarFrameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
        Uint8List redCarList = (await redCarFrameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

        setState(() {
          mapStyle = value;
          whiteCar = whiteCarList;
          redCar = redCarList;
        });

        if( FirebaseAuth.instance.currentUser != null) {
          locations = FirebaseFirestore.instance.collection('driver_locations').where('status', isEqualTo: true).snapshots().listen((QuerySnapshot snapshot) {
            print('osluskivanje');
            List<QueryDocumentSnapshot> list = snapshot.docs;
            Set<Marker> tempMarkers = Set<Marker>();

            for(int i = 0; i < list.length; i++) {

              DocumentSnapshot snapshot = list.elementAt(i);
              print(snapshot.get('carColor'));
              GeoPoint geoPoint = snapshot.get('location');

              if(!snapshot.get('status')) {
                continue;
              }

              bool isRed = false;
              if(snapshot.get('carColor') == 'red')
                isRed = true;

              tempMarkers.add(Marker(
                  markerId: MarkerId(snapshot.id),
                  position: LatLng(geoPoint.latitude, geoPoint.longitude),
                  draggable: false,
                  zIndex: 2,
                  rotation: snapshot.get('heading'),
                  flat: true,
                  anchor: Offset(0.5, 0.5),
                  icon: isRed ? BitmapDescriptor.fromBytes(redCar!) : BitmapDescriptor.fromBytes(whiteCar!),
                  //on tap shows bottom scrollable sheet with some driver info
                  onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => DriverBottomSheet(driverId: snapshot.id,))

              ));
            }
            setState(() {
              //markers.clear();
              markers = tempMarkers;
            });
          });
        }

      });
      setState(() {
        isFirstRun = false;
      });
    }


  }


  final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(43.7971787003, 18.0917896843),
    zoom: 16
  );


  @override
  Widget build(BuildContext context) {


        if( mapStyle == null)
          return Container(
            child: Center(
              child: Text('Map style is null'),
            ),
          );

        if(initialCameraPosition == null)
          return Center(
              child: Text('Initial camera position is null'),

          );

        bool expandMap = Provider.of<HomeProvider>(context).isOverlayShown;


        return GoogleMap(
          onTap: (LatLng latLng) => Provider.of<HomeProvider>(context, listen: false).updateOverlay(),
          initialCameraPosition: initialCameraPosition!,
          onMapCreated: (GoogleMapController controller) async{
            controller.setMapStyle(mapStyle);
            mapController.complete(controller);
            Timer(const Duration(seconds: 1), () async {
              Uint8List? snapshot = await controller.takeSnapshot();
              Provider.of<MapSnapshotProvider>(context, listen: false).setSnapshot(snapshot!);
            });
          },
          zoomControlsEnabled: false,
          markers: markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
        );
  }



  @override
  void dispose() {
    super.dispose();
    locations.cancel();
    //x.cancel();
  }
}
