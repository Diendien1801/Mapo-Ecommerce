import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/features/shop/controllers/cart_controller.dart';
import 'package:store/features/shop/models/cart_item_model.dart';
import 'package:store/utils/constants/colors.dart';

// ignore: non_constant_identifier_names
Widget RemoveAndAddProductInCart(CartItemModel itemCart) {
  final controller = CartController.instance;
  return Row(
    children: [
      Container(
        margin: const EdgeInsets.only(left: 30, right: 10),
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.remove,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            controller.removeOneFromCart(itemCart);
          },
        ),
      ),
      Obx(() => Text(
          controller.getProductQuantityInCart(itemCart.productId).toString())),
      Container(
        margin: const EdgeInsets.only(left: 10),
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: TColors.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            controller.addOneToCart(itemCart);
          },
        ),
      ),
    ],
  );
}
