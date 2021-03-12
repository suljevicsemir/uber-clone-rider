import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:uber_clone/services/cached_data/temp_directory_service.dart';
import 'package:uber_clone/services/firebase/storage/storage_provider.dart';

class CachedDataProvider extends ChangeNotifier {

  Map<String, File> driverPictures = {};
  File userProfilePicture;
  final TempDirectoryService _tempDirectoryService = TempDirectoryService();
  final FirebaseStorageProvider _storageProvider = FirebaseStorageProvider();
  CachedDataProvider() {

    loadCachedPictures();

    print('called cached data provider');

  }



  Future<void> loadCachedPictures() async {
    userProfilePicture = await _loadUserPicture();
    driverPictures = await _loadDriversPictures();
    notifyListeners();
    print('finished loading');
  }

  Future<File> _loadUserPicture() async {
    userProfilePicture =  await _tempDirectoryService.loadUserPicture();
    print('Loaded picture from local');
    if(userProfilePicture == null) {
      print('profile pic is null');
      Uint8List list = await FirebaseStorageProvider.getCurrentUserPicture();
      userProfilePicture = await TempDirectoryService.storeUserPicture(list);
    }
    return userProfilePicture;
  }

  Future<Map<String, File>> _loadDriversPictures() async {
    return await _tempDirectoryService.loadDriversPictures();
  }

  Future<void> storeDriverPicture(String driverId) async {

    Uint8List list = await FirebaseStorageProvider.getDriverPicture(driverId);
    driverPictures[driverId] = await TempDirectoryService.storeDriverPicture(driverId, list);
    notifyListeners();

  }

  Future<void> deleteDriverDirectory() async {
   await _tempDirectoryService.deleteDriverDirectory();
  }

  Future<void> deleteUserPicture() async {
    await _tempDirectoryService.deleteUserPicture();
  }


}