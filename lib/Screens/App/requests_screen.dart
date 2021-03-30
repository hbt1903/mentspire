import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Controllers/requests_controller.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/custom_avatar.dart';
import 'package:mentspire/Widget/request_card.dart';

final _user = AppUser.instance;

class RequestsScreen extends StatelessWidget {
  final RequestsController _controller = Get.put(RequestsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomAvatar(_user.photo, Get.width),
        ),
        title: Text("Pending Requests", style: titleTextStyle),
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
                    children: _controller.pendingRequests
                        .map(
                          (u) => RequestCard(
                            u,
                            onTap: () => _controller.showProfile(u),
                          ),
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
