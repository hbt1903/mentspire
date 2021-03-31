import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentspire/Controllers/reset_password_controller.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/custom_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ResetPasswordController(), fenix: true);
    final ResetPasswordController _controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text("RESET PASSWORD", style: titleTextStyle),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.jpeg",
                width: Get.width * .3,
                height: Get.width * .3,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 16),
                    TextField(
                      controller: _controller.emailController,
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx(
                      () => CustomButton(
                        label: "Reset Password",
                        loading: _controller.loading.isTrue,
                        onTap: _controller.sendResetPasswordMail,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
