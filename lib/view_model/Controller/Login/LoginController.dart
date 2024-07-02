import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:blog_flutter_getx/Utils/Utils.dart';
import 'package:blog_flutter_getx/Routes/Routes_name.dart';
import 'package:blog_flutter_getx/view_model/Services/SessionManager.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _ref = FirebaseDatabase.instance.ref().child('user');

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final emailFocus = FocusNode().obs;
  final passwordFocus = FocusNode().obs;
  final loading = false.obs;

  void login(String email, String password, BuildContext context) async {
    loading.value = true;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        SessionManager().userId=userCredential.user!.uid;
        await _ref.child(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'returnSecureToken': true,
        });
        loading.value = false;
        Get.toNamed(RouteName.dashboardScreen);
        Utils.snackBar('Login', 'Login Successful');
      } else {
        loading.value = false;
        Utils.snackBar('Error', 'Login failed. Please try again.');
      }
    } catch (e) {
      loading.value = false;
      Utils.snackBar('Error', 'Login failed: $e');
    }
  }

  @override
  void onClose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    emailFocus.value.dispose();
    passwordFocus.value.dispose();
    super.onClose();
  }
}
