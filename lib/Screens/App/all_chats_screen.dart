import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Controllers/all_chats_controller.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/chat_card.dart';
import 'package:mentspire/Widget/custom_avatar.dart';

final _user = AppUser.instance;

class AllChatsScreen extends StatelessWidget {
  final AllChatsController _controller = Get.put(AllChatsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomAvatar(_user.photo, Get.width),
        ),
        title: Text("Chats", style: titleTextStyle),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
        ],
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
                    children: _controller.chats
                        .map(
                          (c) => ChatCard(c, onTap: () {}),
                        )
                        .toList(),
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
