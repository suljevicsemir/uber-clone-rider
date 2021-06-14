import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/home_provider.dart';
import 'package:uber_clone/providers/location_provider.dart';

class HomeMap extends StatefulWidget {
  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {

  Completer<GoogleMapController> mapController = Completer();
  Set<Marker> markers = Set<Marker>();






  dynamic x;

  late StreamSubscription locations;




  @override
  Widget build(BuildContext context) {

    if( !Provider.of<LocationProvider>(context).mapReady) {
      return Center(
        child: Text('Loading assets...'),
      );
    }

     return GoogleMap(
      onTap: (LatLng latLng) => Provider.of<HomeProvider>(context, listen: false).updateOverlay(),
      initialCameraPosition: CameraPosition(
        target: Provider.of<LocationProvider>(context, listen: false).lastLocation!,
        zoom: 16
      ),
      onMapCreated: (GoogleMapController controller) async{
        controller.setMapStyle(Provider.of<LocationProvider>(context, listen: false).mapStyle);
        mapController.complete(controller);
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
