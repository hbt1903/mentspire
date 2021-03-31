import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentspire/Controllers/login_controller.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/custom_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController(), fenix: true);
    final LoginController _controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN", style: titleTextStyle),
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
                flex: 5,
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
                      () => TextField(
                        controller: _controller.passwordController,
                        obscureText: _controller.passwordVisible.isFalse,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: _controller.passwordVisible.isFalse
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: _controller.passwordVisible.toggle,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx(
                      () => CustomButton(
                        label: "Login",
                        loading: _controller.loading.isTrue,
                        onTap: _controller.login,
                      ),
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: _controller.goToResetPassword,
                      child: Text(
                        "Forgot password?\nReset now",
                        style: infoTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'If you dont have an account, please ',
                  style: infoTextStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Register',
                      style: boldInfoTextStyle.copyWith(color: darkGrey),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _controller.goToRegister,
                    ),
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
