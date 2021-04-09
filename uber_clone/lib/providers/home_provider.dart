


import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier{

  bool _isOverlayShown = true;


  void updateOverlay() {
    _isOverlayShown = !_isOverlayShown;
    notifyListeners();
  }


  bool get isOverlayShown => _isOverlayShown;

}