// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:store/common/widgets/appbar/appbar.dart';
import 'package:store/common/widgets/product_item/item_card_horizontal.dart';
import 'package:store/features/shop/controllers/cart_controller.dart';
import 'package:store/features/shop/views/checkout/checkout.dart';
import 'package:store/features/shop/views/product_details/widget/remove_and_add_in_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CheckoutScreen(cartItems: controller.cartItems),
              ),
            );
          },
          child: Obx(
            () => Text('Checkout \$${controller.totalCartPrice}',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TAppBar(
              leadingOnPressed: () => Navigator.pop(context),
              leadingIcon: Icons.arrow_back_ios,
              title: Text(
                'Cart',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Obx(
              () => Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 170,
                child: ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Column(
                        children: [
                          // controller.getProductQuantityInCart(
                          //             controller.cartItems[index].productId) !=
                          //         0
                          // ?

                          ItemCardHorizontal(
                            itemCart: controller.cartItems[index],
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, left: 60),
                                child: RemoveAndAddProductInCart(
                                    controller.cartItems[index]),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 100,
                                  top: 16,
                                ),
                                child: Text(
                                  (controller.cartItems[index].price *
                                          controller.cartItems[index].quantity)
                                      .toString(),
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ],
                          ),

                          //: Container(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
