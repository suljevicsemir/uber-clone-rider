


import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class UberService extends GetxController {

  var driversMarkers = Set<Rx<Marker>>().obs;


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

  }

  Future<void> _loadCarImages() async {

    ByteData whiteCarData = await rootBundle.load('assets/images/white_car.png');
    ByteData redCarData = await rootBundle.load('assets/images/red_car.png');

    ui.Codec whiteCarCodec = await ui.instantiateImageCodec(whiteCarData.buffer.asUint8List(), targetWidth: 130, targetHeight: 60);
    ui.Codec redCarCodec = await ui.instantiateImageCodec(redCarData.buffer.asUint8List(), targetWidth: 120, targetHeight: 110);

    ui.FrameInfo whiteCarFrameInfo = await whiteCarCodec.getNextFrame();
    ui.FrameInfo redCarFrameInfo = await redCarCodec.getNextFrame();

    Uint8List whiteCarList = (await whiteCarFrameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
    Uint8List redCarList = (await redCarFrameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

    whiteCar.value = whiteCarList;
    redCar.value = redCarList;
  }

  Future<void> _loadMapStyle() async {
    mapStyle.value = await rootBundle.loadString('assets/map/style.json');
  }




  @override
  void dispose() {
    super.dispose();

  }
}