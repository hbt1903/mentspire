import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Screens/screens.dart';

final _firestore = FirebaseFirestore.instance;

class NavController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 3);
    super.onInit();
  }

  changePage(int index) {
    tabController.index = index;
    selectedIndex.value = index;
  }

  goToUserProfile(String _uid) async {
    AppUser user = AppUser();
    user.setUid(_uid);
    await user.docRef.get().then((doc) => user.setData(doc.data()));
    Get.to(ProfileScreen(user: user));
  }
}
