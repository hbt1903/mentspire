import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentspire/Models/app_user.dart';

final _user = AppUser.instance;

class Message {
  String message, senderUid;
  DateTime dateTime;

  bool get isMine => _user.uid == senderUid;

  Message.fromJson(Map<String, dynamic> json) {
    message = json["message"] ?? "";
    senderUid = json["sender"] ?? "";
    dateTime = (json["date_time"] as Timestamp).toDate();
  }
}
