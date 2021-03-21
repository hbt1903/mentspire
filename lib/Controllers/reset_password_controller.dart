import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Helpers/show_snackbar.dart';
import 'package:mentspire/Themes/colors.dart';

final _auth = FirebaseAuth.instance;

class ResetPasswordController extends GetxController {
  RxBool loading = false.obs;
  TextEditingController emailController = TextEditingController();

  bool get emailValid => GetUtils.isEmail(emailController.text);

  bool validate() {
    if (emailValid)
      return true;
    else
      showSnackBar("Email is not valid!", color: red);
    return false;
  }

  sendResetPasswordMail() async {
    if (validate()) {
      loading.toggle();
      try {
        await _auth.sendPasswordResetEmail(email: emailController.text);
        Get.back();
        showSnackBar(
          "Password reset email is sent to\n${emailController.text}",
          color: green,
        );
      } catch (e) {
        showSnackBar(e.message, color: red);
      }
      loading.toggle();
    }
  }
}
