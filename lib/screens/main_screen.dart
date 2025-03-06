
// Main Screen with Bottom Navigation
import 'package:flutter/material.dart';
import 'package:flutter_test_app/screens/home_screen.dart';
import 'package:flutter_test_app/screens/search_screen.dart';
import 'package:get/get.dart';

import '../controllers/bottom_bar_controller.dart';
import '../controllers/product_controller.dart';

class MainScreen extends StatelessWidget {
  final BottomNavController navController = Get.put(BottomNavController());
  final ProductController productController = Get.put(ProductController());

  final List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screens[navController.selectedIndex.value]),
      bottomNavigationBar: Obx(() => Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // Removes ripple effect
          highlightColor: Colors.transparent, // Removes highlight effect
        ),
        child: BottomNavigationBar(
          currentIndex: navController.selectedIndex.value,
          onTap: navController.changeTab,
          type: BottomNavigationBarType.fixed, // Avoids elevation effect
          elevation: 0, // Removes shadow
          backgroundColor: Colors.white, // Set your desired color
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          ],
        ),
      )),
    );
  }
}