
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CachedPicture {


  Future<void> x() async {
    final Directory temp = await getTemporaryDirectory();
    final File imageFile = File('${temp.path}/images/someImageFile.png');


  }


}