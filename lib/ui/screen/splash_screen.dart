import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_implement_getx/ui/screen/login_screen/sign_in_screen.dart';
import '../controllers/auth_controller.dart';
import '../widgets/app_logo.dart';
import '../widgets/screen_background.dart';
import 'bottom_nav_task_screen/main_bottom_nav_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const name='/';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    moveToNextScreen();
    super.initState();
  }
  Future<void> moveToNextScreen()async{
    await Future.delayed(const Duration(seconds: 2));
    bool isUserLoggedIn = await AuthController.isUserLoggedIn();
    if(isUserLoggedIn){
      //Navigator.pushReplacementNamed(context,MainBottomNavScreen.name);
      Get.offNamed(MainBottomNavScreen.name);

    }
    else{
     // Navigator.pushReplacementNamed(context,SignInScreen.name);
      Get.offNamed(SignInScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:ScreenBackground(
        child: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}