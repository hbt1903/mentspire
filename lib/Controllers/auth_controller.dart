import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mentspire/Models/app_user.dart';

final _auth = FirebaseAuth.instance;
final _user = AppUser.instance;

class AuthController extends GetxController {
  RxString currentMessage = "Checking auth state".obs;
  Rx<User> firebaseUser = Rx<User>();

  @override
  onReady() {
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.value = _auth.currentUser;
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  handleAuthChanged(_firebaseUser) async {
    print("Auth state changed");
    if (_firebaseUser == null) {
      Get.offAllNamed("/login");
    } else {
      _user.setUid(_auth.currentUser.uid);
      await fetchUserInfo();
      if (_user.initiated)
        Get.offAllNamed("/home");
      else
        Get.offAllNamed("/country_select");
    }
  }

  Future fetchUserInfo() async {
    DocumentSnapshot snap = await _user.docRef.get();
    Map<String, dynamic> data = snap.data();
    _user.setData(data);
    return;
  }

  signOut() async {
    await _auth.signOut();
  }
}
