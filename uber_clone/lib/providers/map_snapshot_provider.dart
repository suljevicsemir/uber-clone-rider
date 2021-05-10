


import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

class MapSnapshotProvider extends ChangeNotifier {

  Uint8List? _snapshot;

  Future<void> setSnapshot(Uint8List snapshot) async{

    ui.Codec snapshotCodec = await ui.instantiateImageCodec(snapshot, targetWidth: 400, targetHeight: 120);
    ui.FrameInfo snapshotFrameInfo = await snapshotCodec.getNextFrame();
    Uint8List list = (await snapshotFrameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();


    _snapshot = list;
    notifyListeners();
  }

  Uint8List? get snapshot => _snapshot;
}