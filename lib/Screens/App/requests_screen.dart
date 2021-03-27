import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Controllers/requests_controller.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/request_card.dart';

class RequestsScreen extends StatelessWidget {
  RequestsController _controller = Get.put(RequestsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
