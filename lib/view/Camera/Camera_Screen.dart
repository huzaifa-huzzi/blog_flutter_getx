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
  final CameraController cameraController = Get.put(CameraController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).height * 1;
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
        backgroundColor: AppColor.pinkColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Obx(() {
                if (cameraController.image.value == null) {
                  return Text(
                    'Select an Image',
                    style: GoogleFonts.lato(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        height: height * 0.3,
                        width: width * 0.3,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Image.file(
                          cameraController.image.value!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Enter some text',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_enhance_rounded),
        onPressed: () {
          cameraController.getGalleryImage();
        },
      ),
    );
  }
}
