

import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';

class TempDirectoryService {
  Directory temp;



  Future<File> loadDriverPicture(String driverId) async {

  }

  Future<File> saveDriverPicture(String driverId) async {

  }


  static Future<File> loadUserPicture() async {
    Directory temp = await getTemporaryDirectory();
    return File('${temp.path}/profilePicture');
  }

  static Future<File> storeUserPicture(Uint8List list) async {
    Directory temp = await getTemporaryDirectory();
    File picture = File('${temp.path}/profilePicture');
    return await picture.writeAsBytes(list);
  }




}