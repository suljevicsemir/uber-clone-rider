



import 'package:get/get.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/firebase/user_data_firestore.dart';
import 'package:uber_clone/services/secure_storage/user_data.dart';

class UserDataController extends GetxController {


  Rx<UserData>? _userData;
  final SecureStorage _secureStorage = SecureStorage();
  final UserDataFirestore _dataFirestore = UserDataFirestore();

  UserDataController() {
    _loadData();
  }

  Future<void> _loadData() async {

    UserData? u = await _secureStorage.loadUser();

    if( u != null) {
      _userData = Rx<UserData>(u);
      return;
    }
    u = await _dataFirestore.loadUser();
    if( u != null)
    _userData = Rx<UserData>(u);

  }


  UserData get user => _userData!.value;






}