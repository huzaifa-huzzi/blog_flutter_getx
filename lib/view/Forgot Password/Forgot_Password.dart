


import 'package:blog_flutter_getx/Resources/Color/colors.dart';
import 'package:blog_flutter_getx/Resources/Components/RoundButton/RoundButton.dart';
import 'package:blog_flutter_getx/Resources/Components/TextInputField/InputField.dart';
import 'package:blog_flutter_getx/Routes/Routes_name.dart';
import 'package:blog_flutter_getx/Utils/Utils.dart';
import 'package:blog_flutter_getx/view_model/Controller/ForgotPassword/ForgotPasswordController.dart';
import 'package:blog_flutter_getx/view_model/Controller/Login/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final controller = Get.put(ForgotPasswordController());

  final _formkey = GlobalKey<FormState>();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.emailFocus.value.dispose();
    controller.emailController.value.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen',style:GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColor.whiteColor,
          ),),),
        centerTitle: true,
        backgroundColor: AppColor.pinkColor,
      ),
      body: SafeArea(
        child:Obx((){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .04),
                  child: Form(
                      key:_formkey ,
                      child: Column(
                        children: [
                          InputField(myController:controller.emailController.value, focusNode: controller.emailFocus.value, onFieldSubmitted: (value){
                          }, obsecureText: false, hint:'Em_ail'.tr , keyboardType: TextInputType.text, onValidator: (value){
                            if(value!.isEmpty){
                              Utils.snackBar('Em_ail'.tr, '_email'.tr);
                            }
                          }, icon:Icons.email),
                        ],
                      )

                  ),
                ),
                SizedBox(height: height * .04,),
                RoundButton(title:'_login'.tr,loading: controller.loading.value, onPress: (){
                  if(_formkey.currentState!.validate()){
                    String email = controller.emailController.value.text;
                    controller.forgotPasswordFtn(email);
                  }
                }),

              ],
            ),
          );
        }),



      ),
    );
  }
}