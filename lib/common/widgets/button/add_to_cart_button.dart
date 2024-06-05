import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/features/shop/controllers/cart_controller.dart';
import 'package:store/features/shop/models/product_model.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/helpers/helper_functions.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  final ProductModel product;

  const ProductCardAddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        final cartItem = cartController.convertToCartItem(product, 1);
        cartController.addOneToCart(cartItem);
      },
      child: Obx(() {
        final productQuantityInCart =
            cartController.getProductQuantityInCart(product.id);
        return Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: productQuantityInCart > 0
                ? TColors.primary
                : dark
                    ? Colors.white
                    : TColors.black,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: productQuantityInCart > 0
              ? Center(
                  child: Text(
                    productQuantityInCart.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: TColors.white),
                  ),
                )
              : Icon(
                  Icons.add,
                  color: dark ? TColors.black : TColors.textWhite,
                ),
        );
      }),
    );
  }
}
