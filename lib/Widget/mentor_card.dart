import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Models/mentor.dart';
import 'package:mentspire/Models/request.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/custom_avatar.dart';
import 'package:mentspire/Widget/skill_tile.dart';

final _user = AppUser.instance;

class MentorCard extends StatelessWidget {
  final AppUser _mentor;
  final Function onTap;
  MentorCard(this._mentor, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                CustomAvatar(_mentor.photo, Get.width * .2),
                Text(_mentor.name, style: titleTextStyle),
                Text(_mentor.school, style: infoTextStyle),
                Text(_mentor.country, style: boldInfoTextStyle),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _mentor.skills
                        .where((skill) => _user.skills.contains(skill))
                        .map((e) => SkillTile(e))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
