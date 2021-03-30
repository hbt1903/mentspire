import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentspire/Controllers/chat_controller.dart';
import 'package:mentspire/Models/chat.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Widget/chat_avatars.dart';
import 'package:mentspire/Widget/message_card.dart';

class ChatScreen extends StatelessWidget {
  final Chat chat;
  ChatScreen(this.chat);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ChatController(chat.id), tag: chat.id);
    ChatController _controller = Get.find(tag: chat.id);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left_rounded),
                    iconSize: 32,
                    onPressed: Get.back,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ChatAvatars(chat.photos[0], chat.photos[1]),
                  ),
                ],
              ),
              Expanded(
                child: Obx(
                  () => ListView(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .025),
                    children: _controller.messages
                        .map((m) => MessageCard(m))
                        .toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller.messageController,
                  focusNode: _controller.messagesFocus,
                  decoration: InputDecoration(
                    hintText: "Your message...",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send_rounded),
                      onPressed: _controller.sendMessage,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
