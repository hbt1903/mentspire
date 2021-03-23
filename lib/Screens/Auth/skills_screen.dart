import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mentspire/Controllers/skills_controller.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:get/get.dart';
import 'package:mentspire/Widget/custom_button.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
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
              Expanded(
                child: ListView(
                  children: [
                    Obx(
                      () => _controller.loadingSkills.isFalse
                          ? MultiSelectFormField(
                              textField: 'display',
                              valueField: 'value',
                              okButtonLabel: 'Save',
                              cancelButtonLabel: 'Cancel',
                              checkBoxCheckColor: white,
                              checkBoxActiveColor: green,

                              dialogTextStyle: infoTextStyle,
                              title: Text("Skills", style: boldInfoTextStyle),
                              chipBackGroundColor: darkGrey,
                              chipLabelStyle: chipLabelTextStyle,
                              // required: true,
                              onSaved: (value) {
                                if (value == null) return;
                                _controller.setSelectedSkils(value);
                              },
                              dataSource: _controller.skills
                                  .map(
                                    (e) => {
                                      "display": e,
                                      "value": e,
                                    },
                                  )
                                  .toList(),
                            )
                          : SpinKitCircle(color: lightGrey, size: 32),
                    ),
                    SizedBox(height: 32),
                    Obx(
                      () => CustomButton(
                        label: "Save",
                        loading: _controller.loading.isTrue,
                        onTap: _controller.save,
                      ),
                    ),
                  ],
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
            color: darkGrey,
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
