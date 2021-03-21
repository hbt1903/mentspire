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
      body: SafeArea(
        child: Center(
          child: Column(
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
        ),
      ),
    );
  }
}
