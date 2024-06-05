// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:store/common/widgets/appbar/appbar.dart';
import 'package:store/common/widgets/choice_chip/choice_chip_cus.dart';
import 'package:store/common/widgets/sale_tag/sale_tag.dart';
import 'package:store/features/shop/controllers/brand_controller.dart';
import 'package:store/features/shop/controllers/cart_controller.dart';
import 'package:store/features/shop/models/product_model.dart';
import 'package:store/features/shop/views/product_details/widget/remove_and_add.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailScreen({
    Key? key,
    required this.productModel,
  }) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    var itemCart = cartController.convertToCartItem(widget.productModel, 1);
    final brandController = BrandController.instance;
    var brand = brandController.featuredBrands
        .where((element) => element.name == widget.productModel.brand)
        .last;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 400,
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    //PRODUCT IMAGE
                    Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: NetworkImage(widget.productModel.image),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    // APP BAR
                    Positioned(
                      child: TAppBar(
                        // ignore: avoid_print
                        leadingOnPressed: () => Navigator.pop(context),
                        leadingIcon: Icons.arrow_back_ios,
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.favorite_border_outlined),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),

                    // Container(
                    //   margin:
                    //       const EdgeInsets.only(top: 300, left: 30, right: 20),
                    //   height: 80,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 6,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return Container(
                    //         width: 80,
                    //         margin: const EdgeInsets.only(right: 10),
                    //         decoration: BoxDecoration(
                    //           border: Border.all(
                    //             color: Colors.blue,
                    //             width: 1.0,
                    //           ),
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: Image.asset(
                    //           'assets/images/nike.png',
                    //           height: 50,
                    //           width: 50,
                    //           fit: BoxFit.contain,
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
              // PRODUCT INFORMATION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // STAR AND SHARE
                  Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: const Icon(Icons.star_border_outlined)),
                  Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: const Icon(Icons.share)),
                ],
              ),
              Row(
                children: [
                  // SALE TAGS
                  Container(
                      margin: const EdgeInsets.only(left: 22),
                      child: const SaleTag()),
                  // PRICE
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      '${widget.productModel.price}\$',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
              // NAME
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  widget.productModel.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              // STOCK
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      'Stock:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5, top: 8),
                    child: Text(
                      'In Stock',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              // BRAND INFOR
              Row(
                children: [
                  //LOGO
                  Container(
                      margin: const EdgeInsets.only(left: 20, top: 10),
                      child: Image.network(
                        brand.image,
                        height: 20,
                        width: 20,
                      )),
                  // BRAND NAME
                  Container(
                    margin: const EdgeInsets.only(left: 5, top: 10),
                    child: Text(
                      brand.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  // CHECKED
                  Container(
                    margin: const EdgeInsets.only(left: 5, top: 12),
                    child: Image.asset(
                      'assets/icons/correct.png',
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
              // COLOR OPTIONS
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: Text('Color Options',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: CustomChoiceChip(
                      shape: const CircleBorder(),
                      text: '',
                      color: Colors.red,
                      selected: false,
                      onSelected: (bool selected) {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: CustomChoiceChip(
                      shape: const CircleBorder(),
                      text: '',
                      color: Colors.blue,
                      selected: false,
                      onSelected: (bool selected) {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: CustomChoiceChip(
                      shape: const CircleBorder(),
                      text: '',
                      color: Colors.green,
                      selected: true,
                      onSelected: (bool selected) {},
                    ),
                  ),
                ],
              ),

              // SIZE OPTIONS
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: Text('Size Options',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: CustomChoiceChip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.blue, width: 1.0),
                      ),
                      text: 'EU 32',
                      color: Colors.white,
                      selected: false,
                      onSelected: (bool selected) {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: CustomChoiceChip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.blue, width: 1.0),
                      ),
                      text: 'EU 33',
                      color: Colors.white,
                      selected: false,
                      onSelected: (bool selected) {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: CustomChoiceChip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.blue, width: 1.0),
                      ),
                      text: 'EU 34',
                      color: Colors.white,
                      selected: true,
                      onSelected: (bool selected) {},
                    ),
                  ),
                ],
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 20, top: 30, right: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.black12,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RemoveAndAddProduct(itemCart),
            Container(
              width: 100,
              margin: const EdgeInsets.only(right: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  cartController.addToCart(widget.productModel);
                },
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
