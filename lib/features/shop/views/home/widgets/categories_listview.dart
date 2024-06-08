import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/features/shop/controllers/category_controller.dart';
import 'package:store/features/shop/views/product/product.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/effect/shimmer_effect.dart';

class CategoriesListview extends StatelessWidget {
  const CategoriesListview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryController.instance;
    return Container(
      margin: const EdgeInsets.only(top: 200, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              'Poppular Categories',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: TColors.white),
              textAlign: TextAlign.start,
            ),
          ),
          Obx(
            () => Container(
              height: 90,
              margin: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryController.featuredCategories.length,
                itemBuilder: (context, index) {
                  final category = categoryController.featuredCategories[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductScreen(category: category)));
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
//                                 child:CachedNetworkImage(
//   imageUrl: category.image,
//   placeholder: (context, url) => CircularProgressIndicator(),
//   errorWidget: (context, url, error) => Icon(Icons.error),
//   imageBuilder: (context, imageProvider) => Container(
//     decoration: BoxDecoration(
//       image: DecorationImage(
//         image: imageProvider,
//         fit: BoxFit.contain,
//       ),
//     ),
//   )
// ),
                                child: Image.network(
                                  (category.image),
                                  height: 30,
                                  width: 30,
                                  loadingBuilder:
                                      (context, child, loadingProgress) =>
                                          loadingProgress == null
                                              ? child
                                              : Center(
                                                  child: Column(
                                                    children: [
                                                      ShimmerEffect(
                                                          width: 50,
                                                          height: 50,
                                                          radius: 50),
                                                    ],
                                                  ),
                                                ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5, left: 10),
                          child: Text(
                            category.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: TColors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
