import 'package:blog_flutter_getx/Data/Exception/appException.dart';
import 'package:blog_flutter_getx/Resources/Color/colors.dart';
import 'package:blog_flutter_getx/Routes/Routes_name.dart';
import 'package:blog_flutter_getx/Utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen',style:GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColor.whiteColor,
          ),),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Utils.snackBar('_logout'.tr,'_logout message'.tr);
              Get.toNamed(RouteName.loginScreen);
            }).onError((error,stackTrace){
              ErrorException();
            });
          }, icon:  Icon(Icons.logout,color: AppColor.whiteColor,))
        ],
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.pinkColor,
      ),
      body: const SafeArea(
          child: Column(
            children: [

            ],
          )
      ),

    );
  }
}
