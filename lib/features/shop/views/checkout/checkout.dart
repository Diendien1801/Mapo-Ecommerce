// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:store/common/widgets/appbar/appbar.dart';
import 'package:store/common/widgets/order_overview/order_overview.dart';
import 'package:store/common/widgets/product_item/item_card_horizontal.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/features/shop/controllers/cart_controller.dart';
import 'package:store/features/shop/controllers/order_controller.dart';
import 'package:store/features/shop/models/cart_item_model.dart';
import 'package:store/features/shop/models/order_model.dart';
import 'package:store/utils/constants/colors.dart';

class CheckoutScreen extends StatelessWidget {
  bool isFromDetail;
  final List<CartItemModel>? cartItems;
  final CartItemModel? cartItemFromDetail;
  CheckoutScreen({
    super.key,
    required this.isFromDetail,
    this.cartItems,
    this.cartItemFromDetail,
  });
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final orderController = Get.put(OrderController());
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          if (isFromDetail) {
            OrderModel order = OrderModel(
              userId: AuthenticationRepository.instance.AuthUser!.uid,
              orderId: (orderController.orders.length + 1).toString(),
              orderDate: DateTime.now().toString(),
              cartItems: [cartItemFromDetail!],
              isDelivered: false,
              shippingDate: DateTime.now().add(Duration(days: 3)).toString(),
            );
            orderController.placeOrderForDetailCheckOut(order);
          } else {
            orderController.placeOrder(OrderModel(
              userId: AuthenticationRepository.instance.AuthUser!.uid,
              orderId: (orderController.orders.length + 1).toString(),
              orderDate: DateTime.now().toString(),
              cartItems: cartItems!,
              isDelivered: false,
              shippingDate: DateTime.now().add(Duration(days: 3)).toString(),
            ));
          }
        },
        child: Container(
          height: 60,
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: TColors.primary,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              'Place Order',
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                    color: TColors.white,
                  ),
            ),
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
                'Order Review',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            // -- ORDER SUMMARY
            Container(
              height: 200,
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: ListView.builder(
                itemCount: isFromDetail ? 1 : cartItems!.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        width: 300,
                        margin: const EdgeInsets.all(10),
                        child: ItemCardHorizontal(
                          itemCart: isFromDetail
                              ? cartItemFromDetail!
                              : cartItems![index],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: isFromDetail
                            ? Text(
                                'x1',
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            : Text(
                                'x${cartItems![index].quantity}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                      )
                    ],
                  );
                },
              ),
            ),

            // --COUNPON
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      'Have a promo code? Enter here',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 40,
                      width: 80,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: TColors.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Apply',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // -- TOTAL
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isFromDetail
                      ? OrderOverview(
                          totalCartPrice: cartItemFromDetail!.price.toDouble())
                      : Obx(
                          () => OrderOverview(
                              totalCartPrice:
                                  controller.totalCartPrice.toDouble()),
                        ),
                  Container(
                    margin: const EdgeInsets.only(top: 40, right: 20, left: 20),
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  // PAYMENT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              'Payment Method',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, right: 20),
                            child: Text(
                              'Change',
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.apply(
                                        color: TColors.primary,
                                      ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 40, top: 10),
                        child: Image.asset(
                          'assets/logos/visa.png',
                          height: 50,
                          width: 50,
                        ),
                      )
                    ],
                  ),

                  // ADDRESS
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              'Shipping Address',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, right: 20),
                            child: Text(
                              'Change',
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.apply(
                                        color: TColors.primary,
                                      ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          '1234 Main Street, New York, NY 10001',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
