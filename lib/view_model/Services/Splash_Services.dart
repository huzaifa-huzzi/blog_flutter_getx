import 'dart:async';
import 'package:blog_flutter_getx/Routes/Routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SplashServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  SplashServices() {
    user = auth.currentUser;
  }

  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      if (user == null) {
        Get.toNamed(RouteName.loginScreen);
      } else {
        Get.toNamed(RouteName.homeScreen);
      }
    });
  }
}
