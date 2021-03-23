import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mentspire/Controllers/skills_controller.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:get/get.dart';
import 'package:swipable_stack/swipable_stack.dart';

class SkillsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SkillsController());
    final SkillsController _controller = Get.find();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: Get.width * .2, bottom: 32),
                child: Text(
                  "Now, select at least 3 skills that you are interested",
                  style: extraBigTitleTextStyle,
                ),
              ),
              Container(
                width: double.infinity,
                height: Get.width * .8,
                child: Center(
                  child: Obx(
                    () => _controller.loadingSkills.isFalse
                        ? _controller.checkedAllSkills.isFalse
                            ? SkillsWidget(_controller)
                            : Text("You have checked all skills")
                        : SpinKitCircle(color: lightGrey, size: 32),
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

class SkillsWidget extends StatelessWidget {
  final SkillsController _controller;

  SkillsWidget(this._controller);
  @override
  Widget build(BuildContext context) {
    return SwipableStack(
      controller: _controller.controller,
      itemCount: _controller.skills.length,
      viewFraction: .9,
      builder: (context, index, constraints) => Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: Get.width,
          height: Get.width * .7,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: green,
          ),
          child: Center(
            child: Text(_controller.skills[index],
                style: boldInfoTextStyle.copyWith(color: white)),
          ),
        ),
      ),
    );
  }
}
