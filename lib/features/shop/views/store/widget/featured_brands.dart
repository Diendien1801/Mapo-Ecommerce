import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/common/widgets/brand_item/brand_card.dart';
import 'package:store/features/shop/controllers/brand_controller.dart';

class FeaturedBrands extends StatelessWidget {
  const FeaturedBrands({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
   
    return Container(
      // ignore: prefer_const_constructors
      margin: EdgeInsets.only(top: 0, left: 20, right: 20),
      child: Obx(
        ()=> GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          children: List.generate(brandController.featuredBrands.length,
              (index) => BrandCard(brandModel: brandController.featuredBrands[index])),
        ),
      ),
    );
  }
}
