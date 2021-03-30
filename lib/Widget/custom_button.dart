import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function onTap;
  final Color textColor, bgColor;
  final bool loading;
  final bool useGreenGredient;
  CustomButton({
    this.label,
    this.onTap,
    this.bgColor,
    this.textColor = white,
    this.loading = false,
    this.useGreenGredient = true,
  });

  @override
  Widget build(BuildContext context) {
    bool bgColorGiven = bgColor != null;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        decoration: BoxDecoration(
          gradient: !bgColorGiven
              ? useGreenGredient
                  ? greenGradient
                  : sinCityRedGradient
              : null,
          color: bgColorGiven ? bgColor : null,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 2,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: loading
              ? SpinKitFadingCircle(color: textColor, size: 24)
              : Text(
                  label,
                  style: boldInfoTextStyle.copyWith(color: textColor),
                ),
        ),
      ),
    );
  }
}
