import 'package:flutter/material.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';

class SkillTile extends StatelessWidget {
  final String _skill;
  final bool small;
  SkillTile(this._skill, {this.small = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(small ? 2 : 4),
      child: Material(
        elevation: small ? 0 : 3,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: small ? 4 : 8,
            horizontal: small ? 8 : 16,
          ),
          decoration: BoxDecoration(
            gradient: purpleGradient,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            _skill,
            style: small
                ? chipLabelTextStyle.copyWith(fontSize: 12)
                : chipLabelTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
