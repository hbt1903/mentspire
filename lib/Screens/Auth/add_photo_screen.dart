import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mentspire/Controllers/add_photo_controller.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:mentspire/Widget/custom_button.dart';

class AddPhotoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddPhotoController());
    final AddPhotoController _controller = Get.find();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: Get.width * .2, bottom: 32),
                child: Text(
                  "Now, select a nice photo",
                  style: extraBigTitleTextStyle,
                ),
              ),
              Center(
                child: Obx(
                  () => Material(
                    borderRadius: BorderRadius.circular(Get.width * .5),
                    elevation: 5,
                    child: InkWell(
                      onTap: _controller.getImage,
                      child: Container(
                        width: Get.width * .5,
                        height: Get.width * .5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Get.width * .5),
                          image: _controller.photoUrlNotEmpty
                              ? DecorationImage(
                                  image:
                                      NetworkImage(_controller.photoUrl.value),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: Center(
                          child: _controller.uploadingPhoto.isTrue
                              ? SpinKitFadingCircle(color: lightGrey, size: 32)
                              : _controller.photoUrlNotEmpty
                                  ? Container()
                                  : Text(
                                      "Select Photo",
                                      textAlign: TextAlign.center,
                                      style: infoTextStyle,
                                    ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              Obx(() => _controller.photoUrlNotEmpty
                  ? Text("You look awesome!", style: infoTextStyle)
                  : Container()),
              SizedBox(height: 32),
              Obx(
                () => CustomButton(
                  label: "Save",
                  loading: _controller.loading.isTrue,
                  onTap: _controller.save,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
