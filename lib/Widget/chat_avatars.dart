import 'package:flutter/material.dart';
import 'package:mentspire/Widget/custom_avatar.dart';

class ChatAvatars extends StatelessWidget {
  final String photo1, photo2;
  ChatAvatars(this.photo1, this.photo2);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 64,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: CustomAvatar(photo1, 64),
          ),
          Positioned(
            left: 32,
            top: 0,
            child: CustomAvatar(photo2, 64),
          ),
        ],
      ),
    );
  }
}
