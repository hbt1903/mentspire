import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Helpers/show_snackbar.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class RegisterController extends GetxController {
  RxString type = "".obs;
  RxBool passwordVisible = false.obs;
  RxBool password2Visible = false.obs;
  RxBool loading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  bool get emailValid => GetUtils.isEmail(emailController.text);
  bool get passwordValid => passwordController.text.length >= 6;
  bool get nameValid => nameController.text.isNotEmpty;
  bool get passwordMatch => passwordController.text == password2Controller.text;

  bool validate() {
    String errorMessage;
    if (!emailValid)
      errorMessage = "Please enter a valid email";
    else if (!passwordMatch)
      errorMessage = "Passwords do not match";
    else if (!passwordValid)
      errorMessage = "Password should be longer than 6 characters";
    else if (!nameValid)
      errorMessage = "Name should not be empty!";
    else
      return true;
    showSnackBar(errorMessage, color: Colors.red);
    return false;
  }

  register() async {
    if (validate()) {
      loading.toggle();
      try {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        User user = cred.user;
        if (user != null) {
          _firestore.collection("users").doc(user.uid).set({
            "email": emailController.text,
            "name": nameController.text,
            "type": type.value,
          });
          showSnackBar("Account is created successfully", color: Colors.green);
        }
      } on FirebaseAuthException catch (e) {
        showSnackBar(e.message, color: Colors.red);
      }
      loading.toggle();
    }
  }

  toggleType() {
    if (type.value == "Mentee") {
      type.value = "Mentor";
    } else
      type.value = "Mentee";
  }

  setType(String _type) {
    type.value = _type;
  }
}
