import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/common/widgets/appbar/appbar.dart';
import 'package:store/common/widgets/product_item/item_card.dart';
import 'package:store/features/shop/controllers/favourite_controller.dart';
import 'package:store/utils/helpers/helper_functions.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final favController = Get.put(FavouriteController());

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'WishList',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            color: !dark ? Colors.black : Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 20),
              color: !dark ? Colors.white : Colors.black,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                  future: favController.favoriteProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      final products = snapshot.data!;
                      if (products.isEmpty) {
                        return const Center(
                          child: Text('No items in wishlist'),
                        );
                      } else {
                        return GridView.builder(
                          itemCount: products.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 300,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (context, index) {
                            return ItemCard(
                                dark: dark, product: products[index]);
                          },
                        );
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
