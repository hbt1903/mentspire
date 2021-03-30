import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentspire/Controllers/nav_controller.dart';
import 'package:mentspire/Screens/App/all_chats_screen.dart';
import 'package:mentspire/Screens/App/profile_screen.dart';
import 'package:mentspire/Screens/App/requests_screen.dart';
import 'package:mentspire/Screens/App/search_screen.dart';
import 'package:mentspire/Screens/screens.dart';
import 'package:mentspire/Themes/colors.dart';

class TabApp extends StatelessWidget {
  final NavController navController = Get.put(NavController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: navController.changePage,
          currentIndex: navController.selectedIndex.value,
          selectedItemColor: darkGrey,
          unselectedItemColor: lightGrey,
          elevation: 20,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: "Requests",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_rounded),
              label: "Chats",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: navController.tabController,
        children: [
          SearchScreen(),
          RequestsScreen(),
          AllChatsScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
