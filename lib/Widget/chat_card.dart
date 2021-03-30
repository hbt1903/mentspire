import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Extensions/extensions.dart';
import 'package:mentspire/Models/chat.dart';
import 'package:mentspire/Screens/App/chat_screen.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/custom_avatar.dart';

final _user = AppUser.instance;

class ChatCard extends StatelessWidget {
  final Chat _chat;
  final Function onTap;
  ChatCard(this._chat, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(ChatScreen(_chat)),
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
                CustomAvatar(_chat.otherPhoto, Get.width * .15),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_chat.otherName, style: titleTextStyle),
                      Text(
                        _chat.lastMessageDateTime.passedTimeString,
                        style: infoTextStyle,
                      ),
                      SizedBox(height: 8),
                      Text(
                        _chat.lastMessage,
                        style: infoTextStyle.copyWith(color: darkGrey),
                      ),
                    ],
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
