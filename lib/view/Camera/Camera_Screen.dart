import 'package:blog_flutter_getx/Resources/Components/RoundButton/RoundButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Resources/Color/colors.dart';
import '../../view_model/Controller/Camera/CameraController.dart';


class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final cameraController = Get.put(CameraController());

  @override
  void dispose() {
    cameraController.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Image',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColor.whiteColor,
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.pinkColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (cameraController.image.value != null) // Show image if selected
              Container(
                height: height * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Image.file(
                  cameraController.image.value!,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: height * 0.03),
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    controller: cameraController.controller,
                    minLines: 5, // Adjust this as per your need
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Enter some text',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  RoundButton(
                    title: 'Upload Image',
                    loading: cameraController.loading.value,
                    onPress: () {
                      cameraController.uploadImage();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: FloatingActionButton(
          child: const Icon(Icons.camera_enhance_rounded),
          onPressed: () {
            cameraController.getGalleryImage();
          },
        ),
      ),
    );
  }
}
