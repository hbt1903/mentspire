import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mentspire/Controllers/auth_controller.dart';
import 'package:mentspire/Screens/App/home_screen.dart';
import 'package:mentspire/Screens/Auth/login_screen.dart';
import 'package:get/get.dart';
import 'package:mentspire/Screens/Auth/register_screen.dart';
import 'package:mentspire/Screens/Auth/reset_password_screen.dart';
import 'package:mentspire/Screens/splash_screen.dart';
import 'package:mentspire/Themes/colors.dart';
import 'package:mentspire/Themes/input_decoration_theme.dart';
import 'package:mentspire/Themes/text_themes.dart';

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
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: "/register", page: () => RegisterScreen()),
        GetPage(name: "/reset_password", page: () => ResetPasswordScreen()),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black12,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.amber,
                  child: Column(
                    children: [Text("deneme"), Text("deneme"), Text("deneme")],
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("image tapped");
                  },
                  child: Image.network(
                    "https://i1.wp.com/www.muratoner.net/wp-content/uploads/2019/01/flutterlogo.png",
                    width: 50,
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
