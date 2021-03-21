import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentspire/Controllers/login_controller.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN", style: titleTextStyle),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://seeklogo.com/images/Y/yves-rocher-logo-0DDF313E61-seeklogo.com.png",
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
              SizedBox(height: 8),
              InkWell(child: Text("forgot pass", style: infoTextStyle)),
            ],
          ),
        ),
      ),
    );
  }
}
