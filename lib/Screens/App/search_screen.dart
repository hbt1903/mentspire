import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Controllers/auth_controller.dart';
import 'package:mentspire/Controllers/mentors_controller.dart';
import 'package:mentspire/Models/mentor.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/mentor_card.dart';
import 'package:mentspire/Widget/request_card.dart';

class _SearchScreenState extends State<SearchScreen> {
  AuthController authController = Get.put(AuthController());
  MentorsController _controller = Get.put(MentorsController());
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: titleTextStyle),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller.searchController,
                onChanged: (t) {
                  setState(() {
                    text = t;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .025),
                    children: _controller.mentor
                        .where((mentor) =>
                            mentor.name
                                .toLowerCase()
                                .contains(text.toLowerCase()) &&
                            mentor.email != authController.user.value.email)
                        .toList()
                        .map(
                          (u) => MentorCard(
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
//
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
  MentorsController _controller = Get.put(MentorsController());
  String text = "";
}
