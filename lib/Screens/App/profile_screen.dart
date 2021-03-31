import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Controllers/auth_controller.dart';
import 'package:mentspire/Controllers/requests_controller.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/custom_avatar.dart';
import 'package:mentspire/Widget/custom_button.dart';
import 'package:mentspire/Widget/skill_tile.dart';

final _authUser = AppUser.instance;

class ProfileScreen extends StatelessWidget {
  final AppUser user;
  ProfileScreen({this.user});
  @override
  Widget build(BuildContext context) {
    AuthController _authController = Get.find();
    final _user = user ?? _authController.user.value;
    return Scaffold(
      appBar: user == null ? null : AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16, top: 16),
                child: CustomAvatar(_user.photo, Get.width * .4),
              ),
              Text(
                _user.name,
                style:
                    boldInfoTextStyle.copyWith(fontSize: 20, color: darkGrey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Icon(Icons.map_rounded, color: darkGrey),
              Text(
                _user.countrySchoolText,
                style: infoTextStyle,
                textAlign: TextAlign.center,
              ),
              Container(
                width: Get.width * .8,
                margin: EdgeInsets.all(8),
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: _user.skills
                      .sublist(0, 3)
                      .map((e) => SkillTile(e))
                      .toList(),
                ),
              ),
              if (_user.uid != _authUser.uid && _authUser.isMentee)
                Obx(() {
                  bool pending = _authController.user.value.pendingUsers
                      .contains(_user.uid);
                  bool accepted =
                      _authController.user.value.addedUsers.contains(_user.uid);
                  return CustomButton(
                    label: accepted
                        ? "Send Message"
                        : !pending
                            ? "Send Request"
                            : "Cancel Request",
                    onTap: () => accepted
                        ? () {}
                        : !pending
                            ? RequestsController.sendRequest(_user)
                            : RequestsController.cancelRequest(_user),
                    useGreenGredient: !pending,
                  );
                }),
              if (_user.uid == _authUser.uid)
                Expanded(
                  child: ListView(
                    children: [
                      renderMenuRow("Change Name", Icons.person, () {}),
                      renderMenuRow("Change Country", Icons.map_rounded, () {}),
                      renderMenuRow("Edit Skills", Icons.edit, () {}),
                      renderMenuRow("Sign Out", Icons.exit_to_app_rounded,
                          _authController.signOut),
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

Widget renderMenuRow(String _label, IconData _icon, Function _onTap) {
  return InkWell(
    onTap: _onTap,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: Get.width * .05),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(icon: Icon(_icon), onPressed: () {}),
              Expanded(
                child: Text(
                  _label,
                  style: labelTextStyle,
                  textAlign: TextAlign.start,
                ),
              ),
              IconButton(
                  icon: Icon(Icons.chevron_right_rounded), onPressed: () {}),
            ],
          ),
        ),
      ),
    ),
  );
}
