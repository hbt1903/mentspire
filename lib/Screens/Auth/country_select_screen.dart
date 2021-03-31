import 'package:country_picker/country_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mentspire/Controllers/country_select_controller.dart';
import 'package:mentspire/Models/app_user.dart';
import 'package:mentspire/Models/university.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'package:get/get.dart';
import 'package:mentspire/Widget/custom_button.dart';

final _user = AppUser.instance;

class CountrySelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CountrySelectController());
    final CountrySelectController _controller = Get.find();
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
                  "Hi ${_user.name}, please select your country and your school",
                  style: extraBigTitleTextStyle,
                ),
              ),
              Obx(
                () => CountrySelector(
                  onSelect: _controller.onSelectCountry,
                  country: _controller.countrySelected
                      ? _controller.selectedCountry.value
                      : null,
                ),
              ),
              SizedBox(height: 32),
              Obx(() {
                if (_controller.universitiesReady && _user.isMentor)
                  return DropdownSearch<University>(
                    mode: Mode.MENU,
                    showSearchBox: true,
                    hint: "Select University",
                    label: "Select University",
                    items: _controller.universities,
                    onChanged: _controller.onSelectUniversity,
                    itemAsString: (item) => item.name,
                    selectedItem: _controller.universitySelected
                        ? _controller.selectedUniversity.value
                        : null,
                  );
                else if (_controller.countrySelected && _user.isMentor)
                  return SpinKitFadingCircle(color: lightGrey, size: 24);
                else
                  return Container();
              }),
              SizedBox(height: 32),
              Obx(
                () => CustomButton(
                  label: "Save",
                  loading: _controller.loading,
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

class CountrySelector extends StatelessWidget {
  final Country country;
  final Function onSelect;
  CountrySelector({this.country, @required this.onSelect});
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(
      text: country == null ? "" : "${country.name} - (${country.countryCode})",
    );
    return InkWell(
      onTap: () => showCountryPicker(context: context, onSelect: onSelect),
      child: TextField(
        controller: _controller,
        enabled: false,
        decoration: InputDecoration(
          filled: false,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: lightGrey,
              width: .5,
            ),
          ),
          suffix: Icon(Icons.arrow_drop_down),
          labelText: "Select Country",
        ),
      ),
    );
  }
}
