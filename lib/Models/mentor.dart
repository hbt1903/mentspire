import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentspire/Models/app_user.dart';

final _firestore = FirebaseFirestore.instance;
final _user = AppUser.instance;

class Mentor {
  String id, name, surname, email, country, school, gender, photo;
  List<String> skills, communication;

  DocumentReference get docRef => _firestore.collection("users").doc(id);

  Mentor.fromJson(String _id, Map<String, dynamic> json) {
    id = _id;
    name = json["name"] ?? "";
    surname = json["surname"] ?? "";
    email = json["email"] ?? "";
    country = json["country"] ?? "";
    school = json["school"] ?? "";
    gender = json["gender"] ?? "";
    photo = json["photo"] ?? "";
    skills = new List<String>.from(json["skills"] ?? []);
    communication = new List<String>.from(json["communication"] ?? []);
  }
}

/*
  String get photoToShow => _user.isMentee ? mentorPhoto : menteePhoto;
  String get nameToShow => _user.isMentee ? mentorName : menteeName;
  String get uidToShow => _user.isMentee ? mentorId : menteeId;*

 */
