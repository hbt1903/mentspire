import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Models/request.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Widget/custom_avatar.dart';

class RequestCard extends StatelessWidget {
  final Request _request;
  final Function onTap;
  RequestCard(this._request, {this.onTap});
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
                CustomAvatar(_request.photoToShow, Get.width * .2),
                Text(_request.nameToShow),
                Text(_request.dateTime.toIso8601String()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
