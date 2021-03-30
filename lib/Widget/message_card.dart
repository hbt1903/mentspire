import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Models/message.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';

class MessageCard extends StatelessWidget {
  final Message _message;
  MessageCard(this._message);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _message.isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: _message.isMine ? Get.width * .2 : 0,
          right: !_message.isMine ? Get.width * .2 : 0,
        ),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              gradient:
                  _message.isMine ? lawrenciumGradient : redSunsetGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(_message.message, style: chipLabelTextStyle),
          ),
        ),
      ),
    );
  }
}
