import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/features/shop/views/home/home.dart';
import 'package:store/features/shop/views/profile/profile.dart';
import 'package:store/features/shop/views/store/store.dart';
import 'package:store/features/shop/views/wishlist/wishlist.dart';

class NavigationMenu extends StatelessWidget {
  final NavigationController navigationController =
      Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: navigationController.selectedIndex.value,
          onDestinationSelected: (index) =>
              navigationController.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.store),
              label: 'Store',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border),
              label: 'Wishlist',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(() => navigationController
          .screens[navigationController.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> screens = [
    HomeScreen(),
    StoreScreen(),
    WishListScreen(),
    ProfileScreen(),
  ];
}
