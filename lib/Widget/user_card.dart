import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Screens/App/profile_screen.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/custom_avatar.dart';
import 'package:mentspire/Widget/skill_tile.dart';

final _user = AppUser.instance;

class UserCard extends StatelessWidget {
  final AppUser _userToShow;
  UserCard(this._userToShow);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(ProfileScreen(user: _userToShow)),
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
            child: Row(
              children: [
                CustomAvatar(_userToShow.photo, Get.width * .2, elevation: 1),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_userToShow.name, style: titleTextStyle),
                      SizedBox(height: 8),
                      Text(_userToShow.countrySchoolText, style: infoTextStyle),
                      SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _userToShow.skills
                              .map((e) => SkillTile(e, small: true))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
