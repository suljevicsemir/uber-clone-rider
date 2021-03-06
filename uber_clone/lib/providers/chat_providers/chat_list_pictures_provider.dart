import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:uber_clone/services/firebase/storage/storage_provider.dart';


// class responsible for retrieving and saving pictures to
// device's temp directory, is a provider for Chats screen

class ChatListPicturesProvider {

  Directory temp;

  ChatListPicturesProvider( ) {
    _initialize();
  }

  Future<void> _initialize() async {
    temp = await getTemporaryDirectory();
  }

  Future<File> saveDriverImage(Uint8List list, String driverId) async {
    File picture = File('${temp.path}/images/drivers/$driverId');
    File x = await picture.writeAsBytes(list);
    return x;
  }

  Future<File> loadImage(String driverId) async {
    File picture = File('${temp.path}/images/drivers/$driverId');
    if(await picture.exists()) {
      return picture;
    }

    Uint8List imageBytes = await FirebaseStorageProvider.getDriverPicture(driverId);
    await picture.create();
    picture = await picture.writeAsBytes(imageBytes);
    return picture;
  }




}