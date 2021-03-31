import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentspire/Controllers/nav_controller.dart';
import 'package:mentspire/Helpers/show_snackbar.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Models/mentor.dart';
import 'package:mentspire/Models/request.dart';
import 'package:mentspire/Themes/colors.dart';

final _firestore = FirebaseFirestore.instance;
final _user = AppUser.instance;

class MentorsController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxBool loading = false.obs;
  RxBool showSkillFilter = false.obs;
  RxList<AppUser> mentor = List<AppUser>().obs;
  RxList<AppUser> mentorsToShow = List<AppUser>().obs;
  RxList<String> selectedSkills = List<String>().obs;

  List<AppUser> get mentors =>
      mentorsToShow.isNotEmpty ? mentorsToShow : mentor;

  @override
  onInit() {
    mentor.bindStream(mentorsStream());
    mentorsToShow.bindStream(mentorsStream());
    super.onInit();
  }

  setMentorsToShow() {
    mentorsToShow.assignAll(mentor);
    if (searchController.text.isNotEmpty)
      mentorsToShow = mentor
          .where((user) => user.name
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList()
          .obs;
    if (selectedSkills.isNotEmpty) {
      print("selected skills not empty");
      mentorsToShow = mentorsToShow
          .where((user) => user.skills
              .toSet()
              .intersection(selectedSkills.toSet())
              .isNotEmpty)
          .toList()
          .obs;
    }
  }

  toggleShowSkills() {
    selectedSkills.clear();
    setMentorsToShow();
    showSkillFilter.toggle();
  }

  showProfile(AppUser _req) {
    print(searchController.text);
    Get.find<NavController>().goToUserProfile(_req.uid);
  }

  setSelectedSkils(List<dynamic> _values) {
    selectedSkills = _values.map((e) => e.toString()).toList().obs;
    setMentorsToShow();
  }

  Future updateRequestState(Request _req, String _newState) async {
    try {
      await _req.docRef.update({"state": _newState});
    } catch (e) {}
  }

  Stream<List<AppUser>> mentorsStream() {
    return _firestore
        .collection("users")
        .where("type", isEqualTo: "Mentor")
        .where("skills", arrayContainsAny: _user.skills)
        .snapshots()
        .map((snap) {
      List<AppUser> users = [];
      snap.docs.forEach((element) {
        AppUser user = AppUser();
        user.setUid(element.id);
        user.setData(element.data());
        users.add(user);
      });
      return users;
    });
  }

  @override
  void onClose() {
    searchController.clear();
    super.onClose();
  }
}
