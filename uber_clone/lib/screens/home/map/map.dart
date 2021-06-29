import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/location_provider.dart';
import 'package:uber_clone/screens/getx_controllers/uber_service.dart';

class HomeMap extends StatefulWidget {
  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {

  Completer<GoogleMapController> mapController = Completer();

  Set<Marker> markers = Set<Marker>();


  final UberService controller = Get.put(UberService());
  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(seconds: 1), () {
      FirebaseFirestore.instance
          .collection('mocking')
          .add({
            'field' : 'value'
          });
    });

  }

  @override
  Widget build(BuildContext context) {

    if( !Provider.of<LocationProvider>(context).mapReady) {
      return Center(
        child: Text('Loading assets...'),
      );
    }

    return Obx(() {

      if( !controller.areAssetsReady.value) {
        return Container(
          child: Center(
            child: Text('Loading assets...'),
          ),
        );
      }

      return GoogleMap(
        //onTap: (LatLng latLng) => Provider.of<HomeProvider>(context, listen: false).updateOverlay(),
        initialCameraPosition: CameraPosition(
            target: Provider.of<LocationProvider>(context, listen: false).lastLocation!,
            zoom: 16
        ),
        onMapCreated: (GoogleMapController controller) async{
          controller.setMapStyle(this.controller.mapStyle.value);
          mapController.complete(controller);
        },
        zoomControlsEnabled: false,
        markers: this.controller.driversMarkers.value,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
      );
    });


  }



  @override
  void dispose() {
    super.dispose();
  }
}
