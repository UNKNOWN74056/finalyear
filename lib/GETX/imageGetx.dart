import 'dart:io';
import 'package:get/get.dart';

class ImageController extends GetxController {
  final Rx<File?> _image = Rx<File?>(null);

  File? get image => _image.value;
  set image(File? value) => _image.value = value;
}
