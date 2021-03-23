import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentspire/Helpers/show_snackbar.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mentspire/Themes/colors.dart';

final _fbStorage = FirebaseStorage.instance;
final _user = AppUser.instance;

class AddPhotoController extends GetxController {
  RxString photoUrl = _user.photo.obs;
  RxBool uploadingPhoto = false.obs;
  RxBool loading = false.obs;
  File _image;
  ImagePicker _picker = ImagePicker();

  bool get photoUrlNotEmpty => photoUrl.value.isNotEmpty;

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      await uploadImageToFirebase();
    }
  }

  Future uploadImageToFirebase() async {
    print("upload function start");
    uploadingPhoto.value = true;
    String _extension = _image.path.split(".").last;
    String uid = _user.uid ?? "hbt";
    String _fileName = "$uid.$_extension";
    print(_fileName);
    Reference ref = _fbStorage.ref().child('user_photos/$_fileName');
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.resume();
    print("resumed");
    photoUrl.value = await uploadTask.then((snap) async {
      final String url = await snap.ref.getDownloadURL();
      print("Foto yüklendi, url: " + url);
      return url;
    });
    print(photoUrl.value);
    uploadingPhoto.value = false;
    print("uploading value false");
    return;
  }

  save() async {
    if (photoUrl.value.isEmpty) {
      showSnackBar("Please select an image", color: red);
    } else {
      loading.value = true;
      await _user.docRef.update({"photo": photoUrl.value});
      _user.photo = photoUrl.value;
      loading.value = false;
      if (_user.initiated) {
        showSnackBar("Photo updated", color: green);
      } else {
        await _user.docRef.update({"initiated": true});
        _user.initiated = true;
        Get.offAllNamed("/home");
      }
    }
  }
}
