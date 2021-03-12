import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/firebase/user_data_firestore.dart';
import 'package:uber_clone/services/secure_storage/user_data.dart';

class UserDataService {

  final SecureStorage _secureStorage = SecureStorage();
  final UserDataFirestore _dataFirestore = UserDataFirestore();

  Future<UserData> loadUser() async {
    UserData data = await _secureStorage.loadUser();
    if(data != null)
      return data;

    return await _dataFirestore.loadUser();
  }

  Future<bool> saveUserData(UserData userData) async {
    try {
      await _secureStorage.saveUser(userData);
      await _dataFirestore.saveUser(userData);
      return true;
    }
    catch(err) {
      print('GRESKA PRI SPASAVANJU');
      print(err.toString());
      return false;
    }
  }




}