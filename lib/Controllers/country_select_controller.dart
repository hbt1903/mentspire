import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentspire/Helpers/show_snackbar.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Models/university.dart';
import 'package:mentspire/Themes/colors.dart';

final _firestore = FirebaseFirestore.instance;
final _user = AppUser.instance;

class CountrySelectController extends GetxController {
  RxBool _loading = false.obs;
  RxBool _countrySelected = false.obs;
  RxBool _universitySelected = false.obs;
  RxBool _loadingUniversities = true.obs;
  Rx<Country> selectedCountry;
  Rx<University> selectedUniversity;
  RxList<University> universities;

  bool get loading => _loading.isTrue;
  bool get countrySelected => _countrySelected.isTrue;
  bool get universitySelected => _universitySelected.isTrue;
  bool get universitiesReady => countrySelected && _loadingUniversities.isFalse;

  @override
  onInit() {
    universities = List<University>().obs;
    super.onInit();
  }

  onSelectCountry(Country _country) async {
    if (_countrySelected.isFalse) {
      selectedCountry = _country.obs;
      _countrySelected.value = true;
    } else if (_country.countryCode != selectedCountry.value.countryCode) {
      selectedCountry.value = _country;
      if (_user.isMentor || true) {
        universities.clear();
        _universitySelected.value = false;
        await loadUniversities();
      }
    }
  }

  onSelectUniversity(University _university) {
    if (_universitySelected.isFalse) {
      selectedUniversity = _university.obs;
      _universitySelected.value = true;
    } else {
      selectedUniversity.value = _university;
    }
  }

  Future loadUniversities() async {
    _loadingUniversities.value = true;
    Query _query = _firestore.collection("universities").where(
          "alpha_two_code",
          isEqualTo: selectedCountry.value.countryCode,
        );
    QuerySnapshot _querySnap = await _query.get();
    List<QueryDocumentSnapshot> _snaps = _querySnap.docs;
    for (QueryDocumentSnapshot _university in _snaps) {
      universities.add(University.fromJson(_university.data()));
    }
    _loadingUniversities.value = false;
  }

  save() async {
    _loading.value = true;
    await _user.docRef.update({
      "country": selectedCountry.value.name,
      "country_code": selectedCountry.value.countryCode,
    });
    _user.country = selectedCountry.value.name;
    _user.countryCode = selectedCountry.value.countryCode;
    if (_user.isMentor) {
      await _user.docRef.update({
        "school": selectedUniversity.value.name,
      });
      _user.school = selectedUniversity.value.name;
    }
    _loading.value = false;

    if (_user.initiated) {
      showSnackBar("Country updated", color: green);
    } else {
      Get.offAllNamed("/skill_select");
    }
  }
}
