import 'dart:io';
import 'package:blog_flutter_getx/Utils/Utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Services/SessionManager.dart';
import 'package:flutter/material.dart';

class CameraController extends GetxController {
  var image = Rx<File?>(null);
  final picker = ImagePicker();
  final databaseRef = FirebaseDatabase.instance.ref();
  final FirebaseStorage storage = FirebaseStorage.instance;

  // TextEditingController
  final TextEditingController controller = TextEditingController();
  // Loading
  RxBool loading = false.obs;

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

  // Function to upload image to Firebase Storage and save data to Realtime Database
  Future<void> uploadImage() async {
    loading.value = true;

    try {
      if (image.value == null) {
        Utils.snackBar('Error', 'No image selected');
        loading.value = false;
        return;
      }

      // Upload the image to Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child('ProfilePicture/${SessionManager().userId}/blogs/$fileName');
      UploadTask uploadTask = ref.putFile(image.value!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save the image URL and text to the database under the user's blogs node
      await databaseRef.child('ProfilePicture').child(SessionManager().userId!).child('blogs').push().set({
        'imageUrl': downloadUrl,
        'text': controller.text,
        'timestamp': ServerValue.timestamp,
      });

      if (kDebugMode) {
        print('Image and text uploaded successfully.');
      }
      loading.value = false;
    } catch (error) {
      if (kDebugMode) {
        print('Error uploading image: $error');
      }
      loading.value = false;
      Utils.snackBar('Error', 'Failed to upload image.');
    }
  }
}
