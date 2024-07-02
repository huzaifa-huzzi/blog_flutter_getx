import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blog_flutter_getx/Resources/Color/colors.dart';
import 'package:blog_flutter_getx/Resources/Components/RoundButton/RoundButton.dart';
import 'package:blog_flutter_getx/Resources/Components/TextInputField/InputField.dart';
import 'package:blog_flutter_getx/Routes/Routes_name.dart';
import 'package:blog_flutter_getx/Utils/Utils.dart';
import 'package:blog_flutter_getx/view_model/Controller/Login/LoginController.dart';
import 'package:blog_flutter_getx/view_model/Services/SessionManager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Screen',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColor.whiteColor,
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.pinkColor,
      ),
      body: SafeArea(
        child: Obx(() {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .04),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputField(
                            myController: controller.emailController.value,
                            focusNode: controller.emailFocus.value,
                            onFieldSubmitted: (value) {
                              Utils.fieldFocusChange(
                                  context,
                                  controller.emailFocus.value,
                                  controller.passwordFocus.value);
                            },
                            obsecureText: false,
                            hint: 'Email'.tr,
                            keyboardType: TextInputType.text,
                            onValidator: (value) {
                              if (value!.isEmpty) {
                                Utils.snackBar('Email'.tr, 'Enter email'.tr);
                              }
                            },
                            icon: Icons.email,
                          ),
                          SizedBox(height: height * .02),
                          InputField(
                            myController: controller.passwordController.value,
                            focusNode: controller.passwordFocus.value,
                            onFieldSubmitted: (value) {},
                            obsecureText: true,
                            hint: 'Password'.tr,
                            keyboardType: TextInputType.text,
                            onValidator: (value) {
                              if (value!.isEmpty) {
                                Utils.snackBar('Password'.tr, 'Enter password'.tr);
                              }
                            },
                            icon: Icons.lock,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * .04),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.48),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(RouteName.forgotScreen);
                      },
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(),
                          children: [
                            TextSpan(
                              text: 'Forgot Password ? ',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: AppColor.pinkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * .04),
                  RoundButton(
    title: 'Login'.tr,
    loading: controller.loading.value,
    onPress: () async {
    if (_formKey.currentState!.validate()) {
    String email = controller.emailController.value.text;
    String password = controller.passwordController.value.text;

    try {
    // Attempt login
    controller.login(email, password, context);

    // If successful, load the stored blogs
    SessionManager sessionManager = SessionManager();
    await sessionManager.init(); // Initialize session manager
    await sessionManager._loadBlogsFromPrefs(); // Load stored blogs
    List<Map<String, dynamic>> blogs = sessionManager.blogs;

    if (blogs.isNotEmpty) {
    // Navigate to DashboardScreen with blogs
    Get.offNamed(RouteName.dashboardScreen, arguments: blogs);
    } else {
    Utils.snackBar('No Blogs', 'No blogs available for this user.');
    }
    } catch (e) {
    Utils.snackBar('Login Error', e.toString());
    }
    }
    },
                  ),

    SizedBox(height: height * .04),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteName.signupScreen);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: 'Don\'t Have an Account ?',
                        style: TextStyle(),
                        children: [
                          TextSpan(
                            text: 'Sign Up ',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: AppColor.pinkColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
