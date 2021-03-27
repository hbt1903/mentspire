import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentspire/Models/app_user.dart';

final _firestore = FirebaseFirestore.instance;
final _user = AppUser.instance;

class Request {
  String id, mentorId, menteeId, state;
  String mentorName, menteeName, mentorPhoto, menteePhoto;
  DateTime dateTime;
  DocumentReference get docRef => _firestore.collection("requests").doc(id);

  bool get isPending => state == "pending";
  bool get isCanceled => state == "cenceled";
  bool get isAccepted => state == "accepted";

  String get photoToShow => _user.isMentee ? mentorPhoto : menteePhoto;
  String get nameToShow => _user.isMentee ? mentorName : menteeName;
  String get uidToShow => _user.isMentee ? mentorId : menteeId;

  Request.fromJson(String _id, Map<String, dynamic> json) {
    id = _id;
    state = json["state"] ?? "";
    mentorId = json["mentor"] ?? "";
    menteeId = json["mentee"] ?? "";
    mentorName = json["mentor_name"] ?? "";
    menteeName = json["mentee_name"] ?? "";
    mentorPhoto = json["mentor_photo"] ?? "";
    menteePhoto = json["mentee_photo"] ?? "";
    dateTime = (json["date_time"] as Timestamp).toDate();
  }
}
