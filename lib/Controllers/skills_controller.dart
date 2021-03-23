import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swipable_stack/swipable_stack.dart';

final _firestore = FirebaseFirestore.instance;

class SkillsController extends GetxController {
  RxBool loading = false.obs;
  RxBool loadingSkills = true.obs;
  RxBool checkedAllSkills = false.obs;

  RxList<String> skills;
  RxList<String> selectedSkills;
  SwipableStackController controller = SwipableStackController();
  @override
  void onInit() async {
    selectedSkills = List<String>().obs;
    skills = List<String>().obs;
    controller.addListener(() {
      if (controller.currentIndex == skills.length) {
        checkedAllSkills.value = true;
      }
      update();
    });
    fetchSkills();
    super.onInit();
  }

  selectSkill(String _skill) {
    if (!selectedSkills.contains(_skill)) selectedSkills.add(_skill);
  }

  fetchSkills() async {
    QuerySnapshot _querySnap = await _firestore.collection("skills").get();
    _querySnap.docs.forEach((element) {
      skills.add(element.data()["skill"]);
    });
    loadingSkills.value = false;
  }
}
