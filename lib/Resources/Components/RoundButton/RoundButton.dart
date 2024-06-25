import 'package:blog_flutter_getx/Resources/Color/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';



class RoundButton extends StatelessWidget {
  final String title;
  bool loading ;
  final VoidCallback onPress;
  RoundButton({super.key,required this.title,required this.onPress ,this.loading = false});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height *1 ;
    final width = MediaQuery.sizeOf(context).width *1 ;
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height * .05,
            width: width * 0.9,
            decoration: BoxDecoration(
              color: AppColor.pinkColor,
              borderRadius: BorderRadius.circular(10),
            ),
        child:loading ? LoadingIndicator(indicatorType: Indicator.ballClipRotate,colors: [AppColor.whiteColor],) :  Center(child: Text(title,style: TextStyle(color: AppColor.whiteColor),),),
      ),
    );
  }
}
