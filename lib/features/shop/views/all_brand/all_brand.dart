import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/common/widgets/appbar/appbar.dart';
import 'package:store/common/widgets/brand_item/brand_card.dart';
import 'package:store/features/shop/controllers/brand_controller.dart';
import 'package:store/utils/helpers/helper_functions.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final brandController = Get.put(BrandController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              TAppBar(
                leadingOnPressed: () {
                  Navigator.pop(context);
                },
                leadingIcon: Icons.arrow_back_ios,
                title: const Text('All Brands'),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16),
                color:
                    !dark ? const Color.fromARGB(255, 255, 255, 255) : Colors.black,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  itemCount: brandController.allBrands.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 100,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.only(right: 14, top: 10),
                        child: BrandCard(
                          brandModel: brandController.allBrands[index],
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
