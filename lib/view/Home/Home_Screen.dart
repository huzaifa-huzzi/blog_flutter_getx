import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../Data/Exception/appException.dart';
import '../../Routes/Routes_name.dart';
import '../../Utils/Utils.dart';
import 'package:blog_flutter_getx/view_model/Controller/Camera/CameraController.dart';
import 'package:blog_flutter_getx/view_model/Services/SessionManager.dart';
import 'package:blog_flutter_getx/Resources/Color/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.ref().child('user');
  final cameraController = Get.put(CameraController());
  final currentDateTime = DateFormat('MMM dd, yyyy').format(DateTime.now());
  final currentTime = DateFormat('EEE, HH:mm:ss').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Screen',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) async {
                Utils.snackBar('_logout'.tr, '_logout message'.tr);
                Get.toNamed(RouteName.loginScreen);
              }).catchError((error, stackTrace) {
                ErrorException();
              });
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          )
        ],
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.pinkColor,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DatabaseEvent>(
          stream: databaseRef.child(SessionManager().userId.toString()).child('blogs').orderByChild('timestamp').onValue,
          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
              return const Center(child: Text('No blogs available'));
            } else {
              Map<dynamic, dynamic>? blogsMap = snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;
              List<Map<dynamic, dynamic>> blogsList = blogsMap?.entries.map((entry) => Map<dynamic, dynamic>.from(entry.value)).toList() ?? [];

              return Column(
                children: blogsList.map((blogData) {
                  String imageUrl = blogData['imageUrl'];
                  String text = blogData['text'];
                  String date = DateFormat('MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(blogData['timestamp']));
                  String time = DateFormat('EEE, HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(blogData['timestamp']));

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .05, vertical: height * .03),
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  date,
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  time,
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * .02),
                          Container(
                            height: height * .3,
                            width: width * .7,
                            child: imageUrl.isNotEmpty
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover, // Adjust the image fitting as needed
                              ),
                            )
                                : Padding(
                                padding: EdgeInsets.symmetric(vertical: height * 0.9),
                                child: const Center(child: Text('No Blog Available'))),
                          ),
                          SizedBox(height: height * 0.02),
                          Text(
                            text,
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}