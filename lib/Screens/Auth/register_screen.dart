import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mentspire/Controllers/register_controller.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController _controller = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTER", style: titleTextStyle),
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
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                              label: "Mentee",
                              onTap: () => _controller.setType("Mentee"),
                              bgColor: _controller.type.value == "Mentee"
                                  ? darkGrey
                                  : lightGrey,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                              label: "Mentor",
                              onTap: () => _controller.setType("Mentor"),
                              bgColor: _controller.type.value == "Mentor"
                                  ? darkGrey
                                  : lightGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _controller.nameController,
                      decoration: InputDecoration(
                        labelText: "Name Surname",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
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
                      () => TextField(
                        controller: _controller.password2Controller,
                        obscureText: _controller.password2Visible.isFalse,
                        decoration: InputDecoration(
                          labelText: "Password Confirm",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: _controller.password2Visible.isFalse
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: _controller.password2Visible.toggle,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Obx(
                      () => CustomButton(
                        label: "Register",
                        loading: _controller.loading.isTrue,
                        onTap: _controller.register,
                      ),
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
