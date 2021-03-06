import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class CachedPicture {

  Directory temp;


  CachedPicture() {
   x();
  }

  Future<void> x() async {
    temp = await getTemporaryDirectory();
  }


  Future<String> getPath() async{
    temp = await getTemporaryDirectory();
    return temp.path;
  }


  Future<void> _getDirectory() async {
    temp = await getTemporaryDirectory();
    final File prvaSlika = File('${temp.path}/images/prvaSlika.png');
    final File drugaSlika = File('${temp.path}/images/drugaSlika.png');

    if( await prvaSlika.exists()) {

    }
    else {
      try {
        Uint8List imageBytes;
        FirebaseStorage storage = FirebaseStorage.instance;
         imageBytes = await storage.ref('3hpm69.png').getData(100000000);
        await prvaSlika.create(recursive: true);
        await prvaSlika.writeAsBytes(imageBytes);
      }
      catch(err) {
        print(err.toString());
      }
    }

  }

  static Future<File> networkImageToFile(String url) async {
    var response = await http.get(url);
    Directory temp = await getApplicationDocumentsDirectory();
    File file = File('${temp.path}/userProfilePicture.png');
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  static Future<File> saveDriverImage(Uint8List uint8list, String driverId) async{
    Directory temp = await getTemporaryDirectory();
    File picture = File('${temp.path}/images/drivers/$driverId');

    File x = await picture.writeAsBytes(uint8list);
    return x;
  }


}