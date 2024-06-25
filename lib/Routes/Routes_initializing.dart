
import 'package:blog_flutter_getx/Routes/Routes_name.dart';
import 'package:blog_flutter_getx/view/Home/Home_Screen.dart';
import 'package:blog_flutter_getx/view/Login/LoginScreen.dart';
import 'package:blog_flutter_getx/view/SplashScreen/splash_Screen.dart';
import 'package:get/get.dart';

class AppRoutes{

  static appRoutes() => [
    GetPage(name: RouteName.splashScreen, page: () =>const SplashScreen()),
    //view
    GetPage(name: RouteName.homeScreen, page: () =>const HomeScreen()),
    GetPage(name: RouteName.loginScreen, page: () =>const LoginScreen()),

  ];

}