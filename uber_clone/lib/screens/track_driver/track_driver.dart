


import 'dart:async';
import 'dart:typed_data';
import 'dart:ui'as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// currently it's working as intended but gives an error
/// needs to be researched more on how to use flutter engine
///


class TrackDriver extends StatefulWidget {

  final bool openedFromNotification;
  final String? driverId;

  TrackDriver({
    required this.openedFromNotification,
    this.driverId
  });

  @override
  _TrackDriverState createState() => _TrackDriverState();
}

class _TrackDriverState extends State<TrackDriver> {

  String? carColor, mapStyle;
  Uint8List? car;
  CameraPosition? initialCameraPosition;
  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  Marker? marker;


  static const platform = const MethodChannel("RideIdFetcher");

  Future<String?> getRideId() async {
    try {
      return await platform.invokeMethod("getRideId");
    }on PlatformException catch(e) {
      print(e.message);
      return null;
    }
  }

  Future<String?> getDriverId() async {
    try {
      return await platform.invokeMethod("getDriverId");
    }
    on PlatformException catch(e) {
      print(e.message);
      return null;
    }
  }

  Future<String?> getCarColor() async {
    try {
      return await platform.invokeMethod("getCarColor");
    }
    on PlatformException catch (e) {
      print(e.message);
      return null;
    }
  }


  @override
  void initState() {
    super.initState();

    if(widget.openedFromNotification) {

      getDriverId().then((String? driverId) async{
        if( driverId == null) {
          print('Did not fetch driver id');
          return;
        }
        print('Tracking driver with id: ' + driverId);

        String? carColor = await getCarColor();

        if( carColor == null)
          return;

        await load(carColor);
        trackDriver(driverId);
      });
    }

    rootBundle.loadString('assets/map/style.json').then((String value) {
      setState(() {
        mapStyle = value;
      });
    });

  }


  Future<void> load(String carColor) async {

    ByteData carData = await rootBundle.load('assets/images/$carColor'+'_car.png');
    ui.Codec carCodec = await ui.instantiateImageCodec(carData.buffer.asUint8List(), targetWidth: 120, targetHeight: 70);
    ui.FrameInfo carFrameInfo = await carCodec.getNextFrame();
    car = (await carFrameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
    setState(() {

    });
  }



  Future<void> trackDriver(String driverId) async {
    FirebaseFirestore.instance
        .collection('driver_locations')
        .doc(driverId)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {

          GeoPoint geoPoint = documentSnapshot.get('location');
          LatLng latLng = LatLng(geoPoint.latitude, geoPoint.longitude);

          if( carColor == null) {
            setState(() {
              carColor = documentSnapshot.get('carColor');
            });
          }

          if( initialCameraPosition == null) {
            initialCameraPosition = CameraPosition(
                target: latLng,
                zoom: 15
            );

          }

          marker = Marker(
              markerId: MarkerId("trackedDriver"),
              position: latLng,
              zIndex: 2,
              flat: true,
              rotation: documentSnapshot.get('heading'),
              icon: BitmapDescriptor.fromBytes(car!)
          );

        if( this.mounted) {
          setState(() {

          });
        }

          mapController.future.then((GoogleMapController controller) {
            controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: latLng,
              zoom: 15
            )));
          });
        });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(

      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
        ),
        child: Stack(
          children: [
            initialCameraPosition != null && mapStyle != null?
            GoogleMap(
              //zoomControlsEnabled: false,
              //zoomGesturesEnabled: false,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: initialCameraPosition!,
              onMapCreated: (GoogleMapController controller) async{
                await controller.setMapStyle(mapStyle);
                mapController.complete(controller);
              },
              markers: Set.of([marker!]),
            ) : Container(),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.only(top: 40),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.yellowAccent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 5)
                  ),
                  child: Text('Tracking driver...', style: TextStyle(fontSize: 20),)
              ),
            )



            /*Positioned(
              top: 100,
              child: Text(rideId),
            ),
            Positioned(
              top: 100,
              left: 200,
              child: Text(driverId),
            ),

            Positioned(
              top: 500,
              child: ElevatedButton(
                onPressed: () => getRideId(),
                child: Text('click for ride'),
              ),
            ),
            Positioned(
              top: 500,
              left: 150,
              child: ElevatedButton(
                onPressed: () => getDriverId(),
                child: Text('click for driver'),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
