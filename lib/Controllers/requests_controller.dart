import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mentspire/Controllers/nav_controller.dart';
import 'package:mentspire/Helpers/show_snackbar.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Models/request.dart';
import 'package:mentspire/Themes/colors.dart';

final _firestore = FirebaseFirestore.instance;
final _user = AppUser.instance;

class RequestsController extends GetxController {
  RxBool loading = false.obs;
  RxList<Request> pendingRequests = List<Request>().obs;

  @override
  onInit() {
    pendingRequests.bindStream(pendingRequestsStream());
    super.onInit();
  }

  showProfile(Request _req) {
    Get.find<NavController>().goToUserProfile(_req.uidToShow);
  }

  Future updateRequestState(Request _req, String _newState) async {
    try {
      await _req.docRef.update({"state": _newState});
    } catch (e) {}
  }

  Stream<List<Request>> pendingRequestsStream() {
    return _firestore
        .collection("requests")
        .where(_user.isMentor ? "mentor" : "mentee", isEqualTo: _user.uid)
        .where("state", isEqualTo: "pending")
        .orderBy("date_time")
        .snapshots()
        .map((snap) {
      List<Request> reqs = [];
      snap.docs.forEach((doc) {
        reqs.add(Request.fromJson(doc.id, doc.data()));
      });
      return reqs;
    });
  }

  static Future acceptRequest(Request _req) async {
    try {
      await _req.docRef.update({"state": "accepted"});
      await _firestore.collection("users").doc(_req.menteeId).update({
        "pending_users": FieldValue.arrayRemove([_req.mentorId]),
        "added_users": FieldValue.arrayUnion([_req.mentorId]),
      });
      await _firestore.collection("users").doc(_req.mentorId).update({
        "added_users": FieldValue.arrayUnion([_req.menteeId])
      });
      await _firestore.collection("chats").add({
        "uids": [_req.menteeId, _req.mentorId],
        "names": [_req.menteeName, _req.mentorName],
        "photos": [_req.menteePhoto, _req.mentorPhoto],
        "last_message": "${_req.mentorName} Accepted Request",
        "last_message_date_time": DateTime.now(),
      });
      print("Chat added");
    } catch (e) {
      print(e.toString());
    }
  }

  static Future rejectRequest(Request _req) async {
    try {
      await _firestore.collection("users").doc(_req.menteeId).update({
        "pending_users": FieldValue.arrayRemove([_req.mentorId]),
      });
      await _req.docRef.delete();
    } catch (e) {}
  }

  static Future sendRequest(AppUser _mentor) async {
    try {
      await _firestore.collection("requests").add({
        "mentee": _user.uid,
        "mentee_name": _user.name,
        "mentee_photo": _user.photo,
        "mentor": _mentor.uid,
        "mentor_name": _mentor.name,
        "mentor_photo": _mentor.photo,
        "date_time": DateTime.now(),
        "state": "pending",
      });
      await _user.docRef.update({
        "pending_users": FieldValue.arrayUnion([_mentor.uid])
      });
      showSnackBar("Request sent to ${_mentor.name}", color: green);
    } catch (e) {}
  }

  static Future cancelRequest(AppUser _mentor) async {
    try {
      await _firestore
          .collection("requests")
          .where("mentee", isEqualTo: _user.uid)
          .where("mentor", isEqualTo: _mentor.uid)
          .get()
          .then((value) => value.docs.forEach((doc) async {
                await doc.reference.delete();
                return;
              }));
      _user.docRef.update({
        "pending_users": FieldValue.arrayRemove([_mentor.uid])
      });
      showSnackBar("Request canceled", color: red);
    } catch (e) {}
  }
}
