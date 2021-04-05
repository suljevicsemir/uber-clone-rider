
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/services/firebase/firestore/driver_service.dart';

class DriverProfileProvider extends ChangeNotifier{
  final FirestoreDriverService _service = FirestoreDriverService();
  Driver? _driver;
  late String id;

  DriverProfileProvider({required String id}) {
    this.id = id;
    _getDriver();
  }


  Future<void> _getDriver() async {
    _driver = await _service.getDriver(id: id);
    notifyListeners();
  }

  Driver? get driver => _driver;
}