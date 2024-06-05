import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/features/shop/controllers/cart_controller.dart';
import 'package:store/utils/constants/colors.dart';

class CartCounterIcon extends StatelessWidget {
  final Color? iconColor;
  final VoidCallback? onPressed;
  const CartCounterIcon({
    super.key,
    this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        width: 50,
        height: 40,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: Icon(
                Icons.shopping_bag,
                color: iconColor ?? TColors.white,
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Obx(
                    ()=> Text(
                      controller.noOfCartItems.value.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: TColors.white, fontSizeFactor: 0.9),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
