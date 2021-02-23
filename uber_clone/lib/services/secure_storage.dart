import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uber_clone/globals.dart' as globals;
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/models/user_data.dart';

class SecureStorage {

  static FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  static Future<bool> saveUser(UserData userData) async {
    try{
      await _flutterSecureStorage.write(key: globals.providerUserId, value: userData.providerUserId);
      await _flutterSecureStorage.write(key: globals.firstName, value: userData.firstName);
      await _flutterSecureStorage.write(key: globals.lastName, value: userData.lastName);
      await _flutterSecureStorage.write(key: globals.phoneNumber, value: userData.phoneNumber);
      await _flutterSecureStorage.write(key: globals.email, value: userData.email);
      await _flutterSecureStorage.write(key: globals.signedInType, value: userData.signedInType.parseSignedInType());
      await _flutterSecureStorage.write(key: globals.profilePicture, value: userData.profilePicture);
      await _flutterSecureStorage.write(key: globals.firebaseUserId, value: userData.firebaseUserId);
      return true;
    }
    catch (err) {
      return false;
    }
  }

  static Future<UserData> loadUser() async {
    Map<String, String> data = await _flutterSecureStorage.readAll();
    return data.isEmpty ? null : UserData.fromMap(data);


  }


}

