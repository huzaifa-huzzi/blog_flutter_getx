import 'package:blog_flutter_getx/Data/Exception/appException.dart';
import 'package:blog_flutter_getx/Routes/Routes_name.dart';
import 'package:blog_flutter_getx/Utils/Utils.dart';
import 'package:blog_flutter_getx/view_model/Services/SessionManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref().child('user');

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocus = FocusNode().obs;
  final passwordFocus = FocusNode().obs;

  RxBool loading = false.obs;

  void signUpFtn(String email, String password, BuildContext context) async {
    loading.value = true;

    try {
      if (password.length < 6) {
        throw AppException('Password should be at least 6 characters long');
      }

      await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        SessionManager().userId = value.user!.uid.toString();
        Utils.snackBar('_signin'.tr, '_signin successful'.tr);
        Get.toNamed(RouteName.homeScreen);
        ref.child(value.user!.uid.toString()).set({
          'uid': value.user!.uid.toString(),
          'email': value.user!.email.toString(),
          'returnSecureToken': true,
        }).then((_) {
          Utils.snackBar('_Registration'.tr, '_Registration successful'.tr);
          loading.value = false;
        }).catchError((error) {
          Utils.toastMessage(error.toString());
          loading.value = false;
        });
      }).catchError((error) {
        Utils.toastMessage(error.toString());
        loading.value = false;
      });

    } catch (e) {
      if (e is AppException) {
        Utils.toastMessage(e.toString()); // Show the exception message to the user
      } else {
        ErrorException();
      }
      loading.value = false;
    }
  }
}
