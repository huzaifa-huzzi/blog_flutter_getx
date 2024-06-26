import 'package:blog_flutter_getx/Resources/Color/colors.dart';
import 'package:blog_flutter_getx/view/Home/Home_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {



  PersistentTabController  _controller = PersistentTabController(initialIndex: 0);


  List<Widget> _buildScreens() {
  return [
  HomeScreen(),
  ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
  PersistentBottomNavBarItem(
  icon: Icon(Icons.home),
  title: ("Home"),
  activeColorPrimary: CupertinoColors.activeBlue,
  inactiveColorPrimary: CupertinoColors.systemGrey,
  ),
  ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppColor.pinkColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties:const  ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation:const  ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}





//Future<void> _handleLogout(BuildContext context) async {
//     try {
//       await _auth.signOut();
//       Get.toNamed(RouteName.loginScreen);
//     } catch (e) {
//       print("Error logging out: $e");
//       // Handle error if necessary
//     }
//   }