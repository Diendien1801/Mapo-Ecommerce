import "dart:ffi";

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderOverview extends StatelessWidget {
  double totalCartPrice;

  OrderOverview({required this.totalCartPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: ListTile(
            title: Text(
              'Subtotal',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Text(
              '\$ ${totalCartPrice}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: ListTile(
            title: Text(
              'Shipping Fee',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Text(
              '\$ 10',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: ListTile(
            title: Text(
              'Tax Fee',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Text(
              '\$ ${totalCartPrice * 0.1}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: ListTile(
            title: Text(
              'Total',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            trailing: Text(
              '\$ ${totalCartPrice * 1.1 + 10}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
      ],
    );
  }
}
