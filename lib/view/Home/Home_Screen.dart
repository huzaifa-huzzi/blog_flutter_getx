import 'package:blog_flutter_getx/Resources/Color/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.pinkColor,
      ),

    );
  }
}
