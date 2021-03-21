import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Models/app_user.dart';

final _user = AppUser.instance;

class HomeController extends GetxController {
  Rx<AppUser> user = Rx<AppUser>(_user);

  @override
  void onReady() {
    _user.addListener(update);
    super.onReady();
  }
}
