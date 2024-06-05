import 'package:flutter/material.dart';
import 'package:store/common/widgets/appbar/tabbar.dart';
import 'package:store/common/widgets/product_cart/cart_icon.dart';
import 'package:store/common/widgets/search_bar/search_product.dart';
import 'package:store/features/shop/controllers/category_controller.dart';
import 'package:store/features/shop/views/all_brand/all_brand.dart';
import 'package:store/features/shop/views/store/widget/category_tab.dart';
import 'package:store/features/shop/views/store/widget/featured_brands.dart';

class StoreScreen extends StatelessWidget {
  final categories = CategoryController.instance.featuredCategories;
  StoreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            CartCounterIcon(
              onPressed: () {},
              iconColor: const Color.fromARGB(255, 107, 103, 103),
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 370,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      // SEARCH BAR
                      TSearchBar(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              "Featured Brands",
                              style: Theme.of(context).textTheme.headlineMedium,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllBrandScreen()));
                            },
                            child: Container(
                                margin: EdgeInsets.only(top: 20, right: 30),
                                child: Text(
                                  "View all",
                                  style: Theme.of(context).textTheme.labelLarge,
                                )),
                          ),
                        ],
                      ),
                      // BRAND CARDs
                      const FeaturedBrands(),
                    ],
                  ),
                ),
                bottom: TTabBar(
                  tabs: categories
                      .map((category) => Tab(child: Text(category.name)))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories
                .map((category) => CategoryTab(category: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
