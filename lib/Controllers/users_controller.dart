import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mentspire/Models/app_user.dart';

final _firestore = FirebaseFirestore.instance;
final _user = AppUser.instance;

class UsersController extends GetxController {
  RxList<AppUser> users = List<AppUser>().obs;

  @override
  onInit() {
    users.bindStream(usersStream());
    super.onInit();
  }

  fetchUsers() async {}

  Stream<List<AppUser>> usersStream() {
    return _firestore.collection("users").snapshots().map((snap) {
      List<AppUser> _users = [];
      snap.docs.forEach((element) {
        if (element.id != _user.uid) {
          AppUser user = AppUser();
          user.setUid(element.id);
          user.setData(element.data());
          _users.add(user);
        }
      });
      return _users;
    });
  }
}
