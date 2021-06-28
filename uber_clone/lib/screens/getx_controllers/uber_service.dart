


import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/screens/home/home_components/driver_bottom_sheet/driver_bottom_sheet.dart';

class UberService extends GetxController {

  RxSet<Marker> driversMarkers = Set<Marker>().obs;
  late StreamSubscription<QuerySnapshot> driversListener;

  Rxn<Uint8List> whiteCar = Rxn<Uint8List>(), redCar = Rxn<Uint8List>();
  Rxn<String> mapStyle = Rxn<String>();

  RxBool areAssetsReady = false.obs;


  UberService() {
    loadData();

  }

  Future<void> loadData() async {
    await Future.wait([
      _loadCarImages(),
      _loadMapStyle()
    ]);
    areAssetsReady.value = true;
    _startDriversListener();
  }

  Future<void> _loadCarImages() async {

    ByteData whiteCarData = await rootBundle.load('assets/images/white_car.png');
    ByteData redCarData = await rootBundle.load('assets/images/red_car.png');

    ui.Codec whiteCarCodec = await ui.instantiateImageCodec(whiteCarData.buffer.asUint8List(), targetWidth: 120, targetHeight: 70);
    ui.Codec redCarCodec = await ui.instantiateImageCodec(redCarData.buffer.asUint8List(), targetWidth: 120, targetHeight: 110);

    ui.FrameInfo whiteCarFrameInfo = await whiteCarCodec.getNextFrame();
    ui.FrameInfo redCarFrameInfo = await redCarCodec.getNextFrame();

    Uint8List whiteCarList = (await whiteCarFrameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
    Uint8List redCarList = (await redCarFrameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

    whiteCar.value = whiteCarList;
    redCar.value = redCarList;
  }

  Future<void> _loadMapStyle() async {
    mapStyle..value = await rootBundle.loadString('assets/map/style.json');
  }

  void _startDriversListener() {
    driversListener = FirebaseFirestore.instance
        .collection('driver_locations')
        .where('status', isEqualTo: true)
        .limit(50)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      List<DocumentSnapshot> list = querySnapshot.docs;
      driversMarkers.clear();

      for(int i = 0; i < list.length; i++) {
        DocumentSnapshot snapshot = list[i];

        driversMarkers.add(Marker(
            markerId: MarkerId(snapshot.id),
            position: LatLng( snapshot.get('location').latitude, snapshot.get('location').longitude),
            draggable: false,
            zIndex: 2,
            rotation: snapshot.get('heading'),
            anchor: Offset(0.5, 0.5),
            // this subscription isn't started until car pictures aren't loaded
            // it is safe to add a null check
            icon: snapshot.get("carColor") == 'red' ? BitmapDescriptor.fromBytes(redCar.value!) : BitmapDescriptor.fromBytes(whiteCar.value!),
            onTap: () => Get.bottomSheet(
                DriverBottomSheet(driverId: snapshot.id),
                isScrollControlled: true,
            enableDrag: true)
        ));
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
    driversListener.cancel();
  }
}