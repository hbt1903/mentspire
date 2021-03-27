import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:mentspire/Screens/App/tab_app.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/input_decoration_theme.dart';
import 'package:mentspire/Themes/text_themes.dart';
import 'Screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthController authController = Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        primaryColor: green,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: darkGrey),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: infoTextStyle,
          focusedBorder: focusedBorder,
          border: enabledBorder,
          enabledBorder: enabledBorder,
        ),
      ),
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/home', page: () => TabApp()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: "/register", page: () => RegisterScreen()),
        GetPage(name: "/reset_password", page: () => ResetPasswordScreen()),
        GetPage(name: "/country_select", page: () => CountrySelectScreen()),
        GetPage(name: "/skill_select", page: () => SkillsScreen()),
        GetPage(name: "/photo_select", page: () => AddPhotoScreen()),
      ],
    );
  }
}

/*uploadUniversities() async {
  String jsonText = await rootBundle.loadString('assets/universities.json');
  List<dynamic> data = json.decode(jsonText);
  print("${data.length} universities read");
  CollectionReference _ref =
      FirebaseFirestore.instance.collection("universities");

  data.forEach((element) {
    _ref.add((element as Map<String, dynamic>));
  });
}*/
