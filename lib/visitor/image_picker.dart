import 'dart:io';

import 'package:image_picker/image_picker.dart';

File sampleImage;
var tempImage;

Future getImage() async {
  tempImage = await ImagePicker.pickImage(
    source: ImageSource.camera,
    imageQuality: 25,
  );
}
