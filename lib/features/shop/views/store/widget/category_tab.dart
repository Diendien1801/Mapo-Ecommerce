import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/common/widgets/brand_item/brand_card.dart';
import 'package:store/common/widgets/custom_shapes/rouned_image_ver2.dart';
import 'package:store/common/widgets/product_item/item_card.dart';
import 'package:store/features/shop/controllers/brand_controller.dart';
import 'package:store/features/shop/controllers/product_controller.dart';
import 'package:store/features/shop/models/category_model.dart';
import 'package:store/features/shop/models/product_model.dart';
import 'package:store/features/shop/views/product/brand_product.dart';
import 'package:store/utils/helpers/helper_functions.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    super.key,
    required this.category,
  });
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunctions.isDarkMode(context);
    final productController = Get.put(ProductController());
    // fetch all products in the category
    List<ProductModel> categoryProduct = productController.allProducts
        .where((element) => element.categoryId == category.id)
        .toList();

    final brandController = BrandController.instance;

    return SingleChildScrollView(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: InkWell(
                onTap: () {
                  Get.to(() =>
                      BrandProductScreen(brand: brandController.allBrands[4]));
                },
                child: BrandCard(
                  brandModel: brandController.allBrands[4],
                  child: Row(
                    children: List.generate(
                      3,
                      (index) => Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                right: 11, left: 11, top: 10, bottom: 10),
                            child: RoundImageOnline(
                                img: productController.ikeaProduct[index].image,
                                height: 100,
                                width: 100,
                                radius: 20,
                                color:
                                    const Color.fromARGB(255, 245, 242, 242)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: InkWell(
                onTap: () {
                  Get.to(() =>
                      BrandProductScreen(brand: brandController.allBrands[3]));
                },
                child: BrandCard(
                  brandModel: brandController.allBrands[3],
                  child: Row(
                    children: List.generate(
                      3,
                      (index) => Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                right: 11, left: 11, top: 10, bottom: 10),
                            child: RoundImageOnline(
                                img:
                                    productController.appleProduct[index].image,
                                height: 100,
                                width: 100,
                                radius: 20,
                                color:
                                    const Color.fromARGB(255, 245, 242, 242)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Text(
                    "You might like",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, right: 30),
                  child: Text(
                    "View all",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 16),
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                itemCount: categoryProduct.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 300,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return ItemCard(
                    dark: dark,
                    product: categoryProduct[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
