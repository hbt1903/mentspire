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
  RxList<AppUser> mentor = List<AppUser>().obs;

  @override
  onInit() {
    mentor.bindStream(mentorsStream());
    super.onInit();
  }

  showProfile(AppUser _req) {
    print(searchController.text);
    Get.find<NavController>().goToUserProfile(_req.uid);
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
        // .where("state", isEqualTo: "pending")
        .snapshots()
        .map((snap) {
      List<AppUser> users = [];
      snap.docs.forEach((element) {
        AppUser user = AppUser();
        user.setUid(element.id);
        user.setData(element.data());
        if (user.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) users.add(user);
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
