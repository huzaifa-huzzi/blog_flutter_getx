import 'package:blog_flutter_getx/Resources/Color/colors.dart';
import 'package:blog_flutter_getx/Resources/Components/RoundButton/RoundButton.dart';
import 'package:blog_flutter_getx/view_model/Controller/Camera/CameraController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
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
        child: Obx(() {
          return Column(
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
              if (cameraController.image.value != null) // Show form if image is selected
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.03),
                      TextFormField(
                        controller: cameraController.controller,
                        minLines: 4,
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
          );
        }),
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
