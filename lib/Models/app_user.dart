import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class AppUser with ChangeNotifier {
  static AppUser instance = AppUser._();
  String uid, name, email, photo, type, country, countryCode, school;
  bool initiated;
  List<String> skills = [];
  List<String> addedUsers = [];
  List<String> pendingUsers = [];

  bool get isMentor => type == "Mentor";
  bool get isMentee => type == "Mentee";
  String get countrySchoolText => isMentor ? "$country - $school" : "$country";

  DocumentReference get docRef => _firestore.collection("users").doc(uid);
  Query get requestsQuery => _firestore.collection("requests").where(
        isMentor ? "mentor" : "mentee",
        isEqualTo: uid,
      );
  Query get chatsQuery => _firestore
      .collection("chats")
      .where("uids", arrayContains: uid)
      .orderBy("last_message_datetime");

  AppUser();
  AppUser._();

  setUid(String _uid) {
    uid = _uid;
  }

  setData(Map<String, dynamic> data) {
    name = data["name"] ?? "";
    email = data["email"] ?? "";
    photo = data["photo"] ?? "";
    type = data["type"] ?? "";
    country = data["country"] ?? "";
    countryCode = data["country_code"] ?? "";
    school = data["school"] ?? "";
    initiated = data["initiated"] ?? false;
    if (data.containsKey("skills")) {
      skills =
          (data["skills"] as List<dynamic>).map((e) => e.toString()).toList();
    }
    if (data.containsKey("pending_users")) {
      pendingUsers = (data["pending_users"] as List<dynamic>)
          .map((e) => e.toString())
          .toList();
    }
    if (data.containsKey("added_users")) {
      addedUsers = (data["added_users"] as List<dynamic>)
          .map((e) => e.toString())
          .toList();
    }
  }
}
