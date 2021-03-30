import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Models/chat.dart';

final _firestore = FirebaseFirestore.instance;
final _user = AppUser.instance;

class AllChatsController extends GetxController {
  RxList<Chat> chats = List<Chat>().obs;

  Query get chatsQuery =>
      _firestore.collection("chats").where("uids", arrayContains: _user.uid);

  @override
  onInit() {
    chats.bindStream(chatsStream());
    super.onInit();
  }

  Stream<List<Chat>> chatsStream() {
    return chatsQuery
        .orderBy("last_message_date_time", descending: false)
        .snapshots()
        .map((QuerySnapshot docs) {
      List<Chat> _chats = [];
      docs.docs.forEach((element) {
        _chats.add(Chat.fromJson(element.id, element.data()));
      });
      return _chats;
    });
  }
}
