import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uber_clone/services/cached_data/cached_pictures.dart';
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';

class FirebaseStorageProvider {

  static final Reference storageReference = FirebaseStorage.instance.ref();

  static Future<void> uploadProviderProfilePicture(File file) async {


    TaskSnapshot x = await storageReference.child("images/riders/${UberAuth.userId}").putFile(file);

    if(x.state == TaskState.running) {
      print('Running..');
    }
    if(x.state == TaskState.canceled) {
      print('CANCELLED');
    }
    if(x.state == TaskState.paused) {
      print('Paused');
    }

    if(x.state == TaskState.error) {
      print('Error');
    }

    if(x.state == TaskState.success) {
      print('Success');
    }


  }

  static Future<Uint8List> getDriverPicture(String driverId) async {
    return await storageReference.child("images/drivers/$driverId").getData(1000000000);
  }


  Future<void> uploadProfilePicture() async {

    ImagePicker imagePicker = ImagePicker();
    File image;


  }





}