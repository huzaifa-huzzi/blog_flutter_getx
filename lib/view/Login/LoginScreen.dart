import 'package:blog_flutter_getx/Resources/Color/colors.dart';
import 'package:blog_flutter_getx/Resources/Components/RoundButton/RoundButton.dart';
import 'package:blog_flutter_getx/Resources/Components/TextInputField/InputField.dart';
import 'package:blog_flutter_getx/Routes/Routes_name.dart';
import 'package:blog_flutter_getx/Utils/Utils.dart';
import 'package:blog_flutter_getx/view_model/Controller/Login/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

     final controller = Get.put(LoginController());

  final _formkey = GlobalKey<FormState>();
  
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.passwordFocus.value.dispose();
    controller.passwordController.value.dispose();
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
           automaticallyImplyLeading: false,
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
                               Utils.fieldFocusChange(context, controller.emailFocus.value,controller.passwordFocus.value );
                            }, obsecureText: false, hint:'Em_ail'.tr , keyboardType: TextInputType.text, onValidator: (value){
                              if(value!.isEmpty){
                                Utils.snackBar('Em_ail'.tr, '_email'.tr);
                              }
                            }, icon:Icons.email),
                            SizedBox(height: height * .02,),
                            InputField(myController: controller.passwordController.value, focusNode: controller.passwordFocus.value, onFieldSubmitted: (value){}, obsecureText: true, hint: 'pass_word'.tr, keyboardType: TextInputType.number, onValidator: (value){
                              if(value!.isEmpty){
                                Utils.snackBar('pass_word'.tr, '_email'.tr);
                              }
                            }, icon: Icons.lock)

                          ],
                        )

                    ),
                  ),
                  SizedBox(height: height * .04,),
                   Padding(
                     padding: EdgeInsets.only(left: width * 0.48),
                     child: InkWell(
                       onTap: (){
                         Get.toNamed(RouteName.forgotScreen);
                       },
                       child: Text.rich(
                           TextSpan(
                                   style: TextStyle(),
                                      children: [
                                      TextSpan(
                                        text: 'Forgot Passowrd ? ',
                                       style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,color: AppColor.pinkColor),
                                      )
                                      ]
                           ),
                       ),
                     ),
                   ),
                  SizedBox(height: height * .04,),
                  RoundButton(title:'_login'.tr,loading: controller.loading.value, onPress: (){
                      if(_formkey.currentState!.validate()){
                        String email = controller.emailController.value.text;
                        String password = controller.passwordController.value.text;
                        controller.loginFtn(email, password, context);
                      }
                  }),
                  SizedBox(height: height * .04 ,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(RouteName.signupScreen);
                    },
                    child: Text.rich(
                      TextSpan(
                          text: 'Dont Have an Account ?',
                          style: TextStyle(),
                          children: [
                            TextSpan(
                              text: 'Sign Up ',
                              style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.normal,fontSize: 18,color: AppColor.pinkColor),
                            )
                          ]
                      ),

                    ),
                  ),

                ],
              ),
            );
          }),
          
          
          
        ),
    );
  }
}
