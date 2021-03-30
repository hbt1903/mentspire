import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentspire/Models/app_user.dart';

final _user = AppUser.instance;

class Chat {
  String id, lastMessage, senderUid;
  DateTime lastMessageDateTime;
  List<String> names = [], photos = [], uids = [];

  int get myIndex => uids.indexOf(_user.uid);
  int get otherIndex => myIndex != -1 ? 1 - myIndex : -1;

  String get otherName => names[otherIndex] ?? "";
  String get otherPhoto => photos[otherIndex] ?? "";
  String get otherUid => uids[otherIndex] ?? "";

  Chat.fromJson(String _id, Map<String, dynamic> json) {
    id = _id;
    lastMessage = json["last_message"] ?? "";
    senderUid = json["sender"] ?? "";
    lastMessageDateTime =
        (json["last_message_date_time"] as Timestamp).toDate();
    if (json.containsKey("uids")) {
      uids = (json["uids"] as List<dynamic>).map((e) => e.toString()).toList();
    }
    if (json.containsKey("names")) {
      names =
          (json["names"] as List<dynamic>).map((e) => e.toString()).toList();
    }
    if (json.containsKey("photos")) {
      photos =
          (json["photos"] as List<dynamic>).map((e) => e.toString()).toList();
    }
  }
}
