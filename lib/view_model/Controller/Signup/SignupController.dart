import 'package:blog_flutter_getx/Data/Exception/appException.dart';
import 'package:blog_flutter_getx/Routes/Routes_name.dart';
import 'package:blog_flutter_getx/Utils/Utils.dart';
import 'package:blog_flutter_getx/view_model/Services/SessionManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {

  // Firebase Authentication
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref().child('user');



  //for Controllers
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  //for the Focusing
  final emailFocus = FocusNode().obs;
  final passwordFocus = FocusNode().obs;

  // for loading
  RxBool loading = false.obs;

  // All Functions

  void signUpFtn(String email,String password,BuildContext context)async{
    loading.value = true;

    try {
      auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
        SessionManager().userId = value.user!.uid.toString();
        Utils.snackBar('_signin'.tr, '_signin successful'.tr);
        Get.toNamed(RouteName.homeScreen);
        ref.child(value.user!.uid.toString()).set({
          'uid':value.user!.uid.toString(),
          'email':value.user!.email.toString(),
          'returnSecureToken':true,

        }).then((value){
          Utils.snackBar('_Registartion'.tr,  '_Registration successful'.tr);
          loading.value = false;
        }).onError((error, stackTrace){
          ErrorException();
          loading.value = false;
        });
      }).onError((error, stackTrace){
        ErrorException();
        loading.value = false;
      });


    }catch (e){
      ErrorException();
      loading.value = false;
    }

  }




}