
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  StreamSubscription? subscription;
  String? mapStyle;
  Marker? marker;
  Circle? circle;

  CameraPosition? initialCameraPosition;


  Location tracker = Location();

  static final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(43.7843792859, 18.1524735956),
    zoom: 16,
  );

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
    await mapController.future.then((value) {
      value.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              bearing: 0,
              target: LatLng(data.latitude!, data.longitude!),
              tilt: 0
          )
      ));

    });
  }






  @override
  void initState() {
    super.initState();

    getCurrentLocation();

    /*subscription = tracker.onLocationChanged.listen((LocationData? data) async{
        await mapController.future.then((GoogleMapController controller)  {
          if(data == null || data.longitude == null || data.latitude == null )
            return;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: 0,
              target: LatLng(data.latitude!, data.longitude!),
              tilt: 0
            )
          ));
          updateMarkerAndCircle(data);
        });
    });*/

  }

  Future<void> getCurrentLocation() async {
    LocationData data = await tracker.getLocation();
    setState(() {
      initialCameraPosition = CameraPosition(
          target: LatLng(data.latitude!, data.longitude!),
          zoom: 15
      );
    });

   // updateMarkerAndCircle(data);


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

    /*if( marker == null || circle == null ) {
      return Container(
        color: Colors.red,
      );
    }*/

    if( initialCameraPosition == null || mapStyle == null)
      return Container(

      );

    return GestureDetector(

      child: GoogleMap(
        onTap: (LatLng latLng) => Provider.of<HomeProvider>(context, listen: false).updateOverlay(),
        //mapType: MapType.hybrid,
        initialCameraPosition: initialCameraPosition!,
        onMapCreated: (GoogleMapController controller) async{

          mapController.complete(controller);
          await mapController.future.then((GoogleMapController controller) => controller.setMapStyle(mapStyle));
        },
        //markers: Set.of((marker != null) ? [marker!] : []),
        //circles: Set.of((circle != null) ? [circle!] : []),
        onCameraMove: (CameraPosition position) {
          print(position.zoom.toString());
        },
        /*onCameraMove: (CameraPosition position) async{
          await mapController.future.then((GoogleMapController controller) {
            controller.animateCamera(
                CameraUpdate.newCameraPosition(
                    CameraPosition(
                        bearing: 0,
                        target: position.target,
                        tilt: 0,
                        zoom: position.zoom
                    )
                ));
            LocationData data = LocationData.fromMap({
              'latitude' : position.target.latitude,
              'longitude' : position.target.longitude
            });
            updateMarkerAndCircle(data);
          });
        },*/


      ),
    );
  }

  @override
  void dispose() {
    print("dispose called");
    super.dispose();
  }
}
