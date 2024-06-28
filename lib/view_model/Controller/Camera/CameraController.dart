import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../Utils/Utils.dart';

class CameraController extends GetxController {
  var image = Rx<File?>(null);
  final picker = ImagePicker();

  // Function to pick an image from the gallery
  Future<void> getGalleryImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      Utils.snackBar('Error', 'No image selected');
    }
  }
}
