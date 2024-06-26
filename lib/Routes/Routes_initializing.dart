
import 'package:blog_flutter_getx/Routes/Routes_name.dart';
import 'package:blog_flutter_getx/view/Camera_Screen.dart';
import 'package:blog_flutter_getx/view/Forgot%20Password/Forgot_Password.dart';
import 'package:blog_flutter_getx/view/Home/Home_Screen.dart';
import 'package:blog_flutter_getx/view/Login/LoginScreen.dart';
import 'package:blog_flutter_getx/view/SplashScreen/splash_Screen.dart';
import 'package:blog_flutter_getx/view/Dashboard/dashboard_screen.dart';
import 'package:blog_flutter_getx/view/signup/SignUp_Screen.dart';
import 'package:get/get.dart';

class AppRoutes{

  static appRoutes() => [
    GetPage(name: RouteName.splashScreen, page: () =>const SplashScreen()),
    //view
    GetPage(name: RouteName.homeScreen, page: () =>const HomeScreen()),
    GetPage(name: RouteName.loginScreen, page: () =>const LoginScreen()),
    GetPage(name: RouteName.signupScreen, page: () =>const SignUp()),
    GetPage(name: RouteName.forgotScreen, page: () =>const ForgotPassword()),
    GetPage(name: RouteName.dashboardScreen, page: () =>const DashboardScreen()),
    GetPage(name: RouteName.cameraScreen, page: () =>const CameraScreen()),


  ];

}