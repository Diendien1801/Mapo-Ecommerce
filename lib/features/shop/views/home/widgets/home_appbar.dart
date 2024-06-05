import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/common/widgets/appbar/appbar.dart';
import 'package:store/common/widgets/product_cart/cart_icon.dart';
import 'package:store/features/personalization/controllers/user_controller.dart';

import 'package:store/features/shop/views/cart/cart.dart';
import 'package:store/utils/constants/text_string.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.homeAppbarTitle,
            style: Theme.of(context).textTheme.labelMedium!.apply(
                  color: Colors.white,
                ),
          ),
          Obx(() {
            
            return Text(
              controller.user.value.fullName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: Colors.white),
            );
          }),
        ],
      ),
      actions: [
        CartCounterIcon(
          onPressed: () {
            
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            );
          },
          iconColor: Colors.white,
        )
      ],
    );
  }
}
