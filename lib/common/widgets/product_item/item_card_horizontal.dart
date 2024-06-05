// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:store/common/widgets/brand_name/brand_name_with_icon.dart';
import 'package:store/features/shop/models/cart_item_model.dart';

class ItemCardHorizontal extends StatelessWidget {
  CartItemModel itemCart;
  ItemCardHorizontal({
    super.key,
    required this.itemCart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          child: Image.network(
            itemCart.image!,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            brandName(name: itemCart.brandName ?? ''),
            Text(
              itemCart.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ],
    );
  }
}
