import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Controllers/auth_controller.dart';
import 'package:mentspire/Controllers/home_controller.dart';
import 'package:mentspire/Controllers/users_controller.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/custom_avatar.dart';
import 'package:mentspire/Widget/custom_button.dart';
import 'package:mentspire/Widget/user_card.dart';

final _user = AppUser.instance;

class HomeScreen extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());
  final UsersController _usersController = Get.put(UsersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomAvatar(_user.photo, Get.width),
        ),
        title: Text("Home Page", style: titleTextStyle),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Obx(
                  () => ListView(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .025),
                    children:
                        _usersController.users.map((u) => UserCard(u)).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
