import 'package:flutter/material.dart';

class SaleTag extends StatelessWidget {
  const SaleTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 20,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            )),
        child: Center(
          child: Text(
            '25%',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ));
  }
}
