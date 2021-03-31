import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Controllers/auth_controller.dart';
import 'package:mentspire/Controllers/mentors_controller.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Models/mentor.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/mentor_card.dart';
import 'package:mentspire/Widget/request_card.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

final _user = AppUser.instance;

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
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
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: _controller.toggleShowSkills,
                        icon: _controller.showSkillFilter.isFalse
                            ? Icon(Icons.sort)
                            : Icon(Icons.cancel),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (_controller.showSkillFilter.isTrue)
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: MultiSelectFormField(
                      textField: 'display',
                      valueField: 'value',
                      okButtonLabel: 'Filter',
                      cancelButtonLabel: 'Cancel',
                      checkBoxCheckColor: white,
                      checkBoxActiveColor: green,
                      dialogTextStyle: infoTextStyle,
                      title: Text("Skills", style: boldInfoTextStyle),
                      chipBackGroundColor: darkGrey,
                      chipLabelStyle: chipLabelTextStyle,
                      onSaved: (value) {
                        if (value == null) return;
                        _controller.setSelectedSkils(value);
                      },
                      dataSource: _user.skills
                          .map((e) => {"display": e, "value": e})
                          .toList(),
                    ),
                  );
                else
                  return Container();
              }),
              Expanded(
                child: Obx(
                  () => ListView(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .025),
                    children: _controller.mentorsToShow
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
