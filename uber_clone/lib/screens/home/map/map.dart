import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/location_provider.dart';
import 'package:uber_clone/screens/getx_controllers/uber_service.dart';
import 'package:uber_clone/screens/home/home_components/driver_bottom_sheet/driver_bottom_sheet.dart';

class HomeMap extends StatefulWidget {
  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {

  Completer<GoogleMapController> mapController = Completer();

  Set<Marker> driverMarkers = Set<Marker>();


  final UberService controller = Get.put(UberService());
  late StreamSubscription<QuerySnapshot> driversListener;


  @override
  void initState() {
    super.initState();
    
    // Future.delayed(const Duration(seconds: 1), () {
    //   FirebaseFirestore.instance
    //       .collection('mocking')
    //       .add({
    //         'field' : 'value'
    //       });
    // });

    controller.loadData().then((value) {
      driversListener = FirebaseFirestore.instance
          .collection('driver_locations')
          .where('status', isEqualTo: true)
          .limit(50)
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        List<DocumentSnapshot> list = querySnapshot.docs;
        driverMarkers.clear();

        for(int i = 0; i < list.length; i++) {
          DocumentSnapshot snapshot = list[i];

          driverMarkers.add(
              Marker(
                  markerId: MarkerId(snapshot.id),
                  position: LatLng( snapshot.get('location').latitude, snapshot.get('location').longitude),
                  draggable: false,
                  zIndex: 2,
                  rotation: snapshot.get('heading'),
                  anchor: Offset(0.5, 0.5),
                  // this subscription isn't started until car pictures aren't loaded
                  // it is safe to add a null check
                  icon: snapshot.get("carColor") == 'red' ? BitmapDescriptor.fromBytes(controller.redCar.value!) : BitmapDescriptor.fromBytes(controller.whiteCar.value!),
                  onTap: () => Get.bottomSheet(
                      DriverBottomSheet(driverId: snapshot.id),
                      isScrollControlled: true,
                      enableDrag: true)
              )
          );
        }
        setState(() {

        });


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

        initialCameraPosition: CameraPosition(
            target: Provider.of<LocationProvider>(context, listen: false).lastLocation!,
            zoom: 16
        ),
        onMapCreated: (GoogleMapController controller) async{
          controller.setMapStyle(this.controller.mapStyle.value);
          mapController.complete(controller);
        },
        zoomControlsEnabled: false,
        markers: driverMarkers,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
      );
    });


  }



  @override
  void dispose() {
    super.dispose();
    driversListener.cancel();
  }
}
