import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:store/common/widgets/appbar/appbar.dart';
import 'package:store/common/widgets/product_item/item_card.dart';
import 'package:store/features/shop/controllers/product_controller.dart';
import 'package:store/features/shop/models/category_model.dart';
import 'package:store/features/shop/models/product_model.dart';
import 'package:store/utils/helpers/helper_functions.dart';

class ProductScreen extends StatelessWidget {
  final CategoryModel category;
  ProductScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductController());
    List<ProductModel> products = controller.allProducts
        .where((element) => element.categoryId == category.id)
        .toList();
    ;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TAppBar(
              leadingOnPressed: () {
                Navigator.pop(context);
              },
              leadingIcon: Icons.arrow_back_ios,
              title: Text(category.name,
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  label: Text('Sort By'),
                  prefixIcon: Icon(Icons.sort_sharp),
                  border: OutlineInputBorder(),
                ),
                items: [
                  'Name',
                  'Higher Price',
                  'Lower Price',
                  'Newest',
                  'Oldest'
                ].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16),
              color: !dark
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : Colors.black,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                itemCount: products.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 300,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  if (products.length > 0)
                    return ItemCard(
                      dark: dark,
                      product: products[index],
                    );
                  else {
                    return const Center(child: Text('No Products Found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
