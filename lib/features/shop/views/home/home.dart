import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/common/widgets/custom_shapes/circular_container.dart';
import 'package:store/common/widgets/product_item/item_card.dart';
import 'package:store/features/shop/controllers/product_controller.dart';
import 'package:store/features/shop/views/home/widgets/banner_custom.dart';
import 'package:store/features/shop/views/home/widgets/categories_listview.dart';
import 'package:store/features/shop/views/home/widgets/home_appbar.dart';
import 'package:store/common/widgets/search_bar/search_product.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 600,
              color: TColors.primary,
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    // -- SEARCH BAR
                    Container(
                        margin: const EdgeInsets.only(
                          top: 100,
                        ),
                        child: TSearchBar()),

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
                    // -- APP BAR
                    const HomeAppBar(),
                    // -- CATEGORIES
                    const CategoriesListview(),
                    Positioned(
                      top: 350,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        decoration: BoxDecoration(
                          color: !dark
                              ? const Color.fromARGB(255, 245, 242, 242)
                              : Colors.black,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(28),
                          ),
                        ),
                        child: const Column(
                          children: [
                            // -- BANNER
                            BannerCustom(),
                            // -- ITEM GRIDVIEW
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => Container(
                padding: const EdgeInsets.only(left: 16),
                color: !dark
                    ? const Color.fromARGB(255, 245, 242, 242)
                    : Colors.black,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  itemCount: controller.allProducts.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 300,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return ItemCard(
                        dark: dark, product: controller.allProducts[index]);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
