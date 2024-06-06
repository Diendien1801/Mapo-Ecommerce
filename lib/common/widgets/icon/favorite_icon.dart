// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:store/features/shop/controllers/favourite_controller.dart';

// ignore: must_be_immutable
class FavouriteIcon extends StatelessWidget {
  String productId;
  FavouriteIcon({
    super.key,
    required this.productId,
  });
  @override
  Widget build(BuildContext context) {
    final favouriteController = Get.put(FavouriteController());
    return Obx(
      () => InkWell(
        onTap: () {
          favouriteController.toggleFavourite(productId);
        },
        child: favouriteController.isFavourite(productId)
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 20,
              )
            : const Icon(
                Icons.favorite_border,
                color: Colors.black,
                size: 20,
              ),
      ),
    );
  }
}
