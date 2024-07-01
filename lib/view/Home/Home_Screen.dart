import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:loading_indicator/loading_indicator.dart';

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
  final sessionManager = SessionManager();

  late String userId;
  late String currentDateTime;
  late String currentTime;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await sessionManager.init();
    userId = sessionManager.userId ?? '';
    currentDateTime = DateFormat('MMM dd, yyyy').format(DateTime.now());
    currentTime = DateFormat('EEE, HH:mm:ss').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

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
                await sessionManager.clearSession(); // Clear session data on logout
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
        child: StreamBuilder(
          stream: databaseRef.child(userId).onValue,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              Map<dynamic, dynamic>? map = snapshot.data!.value as Map<dynamic, dynamic>?;

              if (map != null) {
                String? imageUrl = map['imageUrl'];
                String? text = map['text'];

                return SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * .02, vertical: height * .04),
                        child: Card(
                          elevation: 10,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    currentDateTime,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    currentTime,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: height * .02),
                              Container(
                                height: 200,
                                width: 300,
                                child: imageUrl != null
                                    ? Image.network(imageUrl)
                                    : const Center(child: Text('No Blog Available')),
                              ),
                              SizedBox(height: height * 0.02),
                              Text(
                                text ?? '',
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Text('Data not available');
              }
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }
}
