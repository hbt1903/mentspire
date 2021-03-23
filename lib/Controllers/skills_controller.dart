import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentspire/Helpers/show_snackbar.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:swipable_stack/swipable_stack.dart';

final _firestore = FirebaseFirestore.instance;
final _user = AppUser.instance;

class SkillsController extends GetxController {
  RxBool loading = false.obs;
  RxBool loadingSkills = true.obs;
  RxBool checkedAllSkills = false.obs;

  RxList<String> skills;
  RxList<String> selectedSkills;
  SwipableStackController controller = SwipableStackController();
  @override
  void onInit() async {
    selectedSkills = _user.skills.obs;
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

  setSelectedSkils(List<dynamic> _values) {
    selectedSkills = _values.map((e) => e.toString()).toList().obs;
    print(selectedSkills.toString());
  }

  fetchSkills() async {
    QuerySnapshot _querySnap = await _firestore.collection("skills").get();
    _querySnap.docs.forEach((element) {
      skills.add(element.data()["skill"]);
    });
    loadingSkills.value = false;
  }

  save() async {
    if (selectedSkills.length < 3) {
      showSnackBar("Please select at least 3 skills", color: red);
    } else {
      loading.value = true;
      await _firestore.collection("users").doc(_user.uid).update({
        "skills": selectedSkills,
      });
      _user.skills.clear();
      _user.skills = selectedSkills;
      loading.value = false;
      if (_user.initiated)
        showSnackBar("Skilss updated succesfully", color: green);
      else
        Get.offAllNamed("/photo_select");
    }
  }
}
