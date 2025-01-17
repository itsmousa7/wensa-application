import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'home.dart';
import 'profilepage.dart';
import 'main.dart';
class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key, String? imageUrl});

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller()); // Get the controller to manage the state
    return Scaffold(
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          elevation: 0, // Remove elevation for a flat look
          backgroundColor: Theme.of(context).colorScheme.background,
          selectedItemColor: button, // Color for selected icon
          unselectedItemColor: Theme.of(context).colorScheme.secondary, // Color for unselected icon
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.selectedIndex.value = index;  // Update selected index
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                controller.selectedIndex.value == 0 ? Iconsax.home_15 : Iconsax.home_2,
                size: 35,
              ),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: Icon(
                controller.selectedIndex.value == 1 ? Iconsax.profile_circle5 : Iconsax.profile_circle,
                size: 35,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(
            () => IndexedStack(
          index: controller.selectedIndex.value, // Set the currently selected index
          children: controller.screens, // Display the screen corresponding to the selected index
        ),
      ),
    );
  }
}

class Controller extends GetxController {
  final Rx<int> selectedIndex = 0.obs; // Observable index, default is 0 (Homepage)

  // List of screens corresponding to each navigation destination
  final screens = [
    HomePage(),        // Index 0 => Home Page
    Profilepage(),     // Index 2 => Profile Page
  ];
}
