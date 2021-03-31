import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mentspire/Controllers/auth_controller.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:get/get.dart';
import 'package:mentspire/Themes/text_themes.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController _controller = Get.find();
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/bg.jpeg",
          width: Get.width,
          height: Get.height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/*
Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitFadingCube(
                color: darkGrey,
                size: 48,
              ),
              SizedBox(height: 32),
              Obx(
                () => Text(
                  _controller.currentMessage.value,
                  style: infoTextStyle,
                ),
              ),
            ],
          ),
 */
