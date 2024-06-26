


import 'package:blog_flutter_getx/Data/Exception/appException.dart';
import 'package:blog_flutter_getx/Utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {

  final auth = FirebaseAuth.instance;

  //for Controllers
  final emailController = TextEditingController().obs;

  //for the Focusing
  final emailFocus = FocusNode().obs;

  // for loading
  RxBool loading = false.obs;


  void forgotPasswordFtn(String email ){
    loading.value = true;

    try{
      auth.sendPasswordResetEmail(email: email).then((value){
        Utils.toastMessage(  '_message Forgot'.tr);
        loading.value = false;


      }).onError((error,stackTrace){
        ErrorException();
        loading.value = false;
      });


    }catch(e){
      ErrorException();
      loading.value = false;
    }

  }





}