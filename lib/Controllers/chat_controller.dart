import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Models/message.dart';

final _user = AppUser.instance;
final _firestore = FirebaseFirestore.instance;

class ChatController extends GetxController {
  final String id;
  ChatController(this.id);
  RxList<Message> messages = List<Message>().obs;
  TextEditingController messageController = TextEditingController();
  FocusNode messagesFocus = FocusNode();

  DocumentReference get docRef => _firestore.collection("chats").doc(id);
  CollectionReference get messagesRef => docRef.collection("messages");

  @override
  onInit() {
    messages.bindStream(messagesStream());
    super.onInit();
  }

  sendMessage() async {
    await messagesRef.add({
      "message": messageController.text,
      "date_time": DateTime.now(),
      "sender": _user.uid,
    });
    await docRef.update({
      "last_message": messageController.text,
      "last_message_date_time": DateTime.now(),
    });
    messageController.clear();
    messagesFocus.unfocus();
  }

  Stream<List<Message>> messagesStream() {
    return messagesRef
        .orderBy("date_time", descending: false)
        .snapshots()
        .map((QuerySnapshot docs) {
      List<Message> messages = [];
      docs.docs.forEach((element) {
        messages.add(Message.fromJson(element.data()));
      });
      return messages;
    });
  }
}
