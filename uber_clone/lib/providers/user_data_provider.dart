import 'package:flutter/cupertino.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';
import 'package:uber_clone/services/firebase/user_data_firestore.dart';
import 'package:uber_clone/services/secure_storage/user_data.dart';

class UserDataProvider extends ChangeNotifier {

  final SecureStorage _secureStorage = SecureStorage();
  final UserDataFirestore _dataFirestore = UserDataFirestore();

  UserData? _userData;

  UserDataProvider() {
    print('user data provider konstruktor');
    if(UberAuth.instance.currentUser != null) {
      _loadUser();
    }
  }

  Future<void> _loadUser() async {
    _userData = await _secureStorage.loadUser();
    if(_userData == null) {
      _userData = await _dataFirestore.loadUser();
    }
    notifyListeners();
  }

  UserData? get userData => _userData;

  set userData(UserData? value) {
    _userData = value;
    notifyListeners();
  }
}