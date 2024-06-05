import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/common/widgets/appbar/appbar.dart';
import 'package:store/common/widgets/custom_shapes/circular_container.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/data/repositories/brand/brand_repository.dart';
import 'package:store/data/repositories/product/product_repository.dart';
import 'package:store/dummy.dart';
import 'package:store/features/personalization/controllers/user_controller.dart';
import 'package:store/features/shop/controllers/banner_controller.dart';
import 'package:store/features/shop/controllers/category_controller.dart';
import 'package:store/features/shop/controllers/profile_controller.dart';
import 'package:store/features/shop/views/change_name/change_name.dart';
import 'package:store/features/shop/views/order/order.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/helpers/helper_functions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    final themeController = Get.put(ProfileController());
    final dark = THelperFunctions.isDarkMode(context);
    final categoryController = CategoryController.instance;
    final bannerController = Get.put(BannerController());
    final productRepository = Get.put(ProductRepository());
    final brandRepository = Get.put(BrandRepository());
    return Scaffold(
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                color: TColors.primary,
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      TAppBar(
                        title: Text(
                          'Account',
                          style:
                              Theme.of(context).textTheme.headlineMedium!.apply(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                      Positioned(
                        top: -150,
                        right: -250,
                        child: CircularContainer(
                          backgroundColor: TColors.textWhite.withOpacity(0.1),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        right: -300,
                        child: CircularContainer(
                          backgroundColor: TColors.textWhite.withOpacity(0.1),
                        ),
                      ),
                      Positioned(
                        top: 90,
                        left: 30,
                        child: Row(
                          children: [
                            // AVATAR
                            const SizedBox(
                              height: 50,
                              width: 50,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // INFORMATION
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(userController.user.value.fullName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .apply(
                                          color: Colors.white,
                                        )),
                                Text(userController.user.value.email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .apply(
                                          color: Colors.white,
                                        )),
                              ],
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            // ICON CHANGE INFORMATION
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ChangeNameScreen()));
                              },
                              icon: const Icon(Icons.edit),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 160,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: dark ? Colors.black : Colors.white,
                          ),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: Text(
                  'Account Settings',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    title: Text(
                      'Change Password',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    leading: const Icon(Icons.lock, color: TColors.primary),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyOrderScreen()));
                    },
                    child: ListTile(
                      title: Text(
                        'My Order',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      leading: const Icon(Icons.shopping_basket,
                          color: TColors.primary),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Change Phone Number',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    leading: const Icon(Icons.phone, color: TColors.primary),
                  ),
                  ListTile(
                    title: Text(
                      'Change Address',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    leading:
                        const Icon(Icons.location_on, color: TColors.primary),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: Text(
                  'App Settings',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    title: Text(
                      'Dark Mode',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    leading:
                        const Icon(Icons.dark_mode, color: TColors.primary),
                    trailing: Switch(
                      value: dark,
                      onChanged: (value) {},
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Safe Mode',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    leading:
                        const Icon(Icons.dark_mode, color: TColors.primary),
                    trailing: Switch(
                      value: themeController.safeMode.value,
                      onChanged: (value) {
                        themeController.safeMode.value = value;
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Notification',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    leading:
                        const Icon(Icons.notifications, color: TColors.primary),
                  ),
                  InkWell(
                    onTap: () {
                      categoryController.uploadDummyData(DummyData.categories);
                    },
                    child: ListTile(
                      title: Text(
                        'Upload categories data',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      leading:
                          const Icon(Icons.language, color: TColors.primary),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      bannerController.uploadDummyData(DummyData.banners);
                    },
                    child: ListTile(
                      title: Text(
                        'Upload banner data',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      leading:
                          const Icon(Icons.language, color: TColors.primary),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      productRepository.uploadDummyData(DummyData.product);
                    },
                    child: ListTile(
                      title: Text(
                        'Upload product data',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      leading:
                          const Icon(Icons.language, color: TColors.primary),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      brandRepository.uploadDummyData(DummyData.brands);
                    },
                    child: ListTile(
                      title: Text(
                        'Upload brands data',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      leading:
                          const Icon(Icons.language, color: TColors.primary),
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: TColors.primary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    AuthenticationRepository.instance.logout();
                  },
                  child: Center(
                    child: Text(
                      'Logout',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
