import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Helpers/show_snackbar.dart';
import 'package:mentspire/Screens/register_screen.dart';

final _auth = FirebaseAuth.instance;

class LoginController extends GetxController {
  RxBool passwordVisible = false.obs;
  RxBool loading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool get emailValid => GetUtils.isEmail(emailController.text);
  bool get passwordValid => passwordController.text.length >= 6;

  validate() {
    String errorMessage;
    if (!emailValid)
      errorMessage = "Please enter a valid email";
    else if (!passwordValid)
      errorMessage = "Password should be longer than 6 characters";
    else
      return true;
    showSnackBar(errorMessage, color: Colors.red);
    return false;
  }

  login() async {
    if (validate()) {
      try {
        loading.toggle();
        UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        User user = cred.user;
        if (user != null) showSnackBar("Login Success", color: Colors.green);
        loading.toggle();
      } catch (e) {
        showSnackBar("Login Failed", color: Colors.red);
      }
    }
  }

  goToRegister() {
    Get.to(RegisterScreen());
  }
}
