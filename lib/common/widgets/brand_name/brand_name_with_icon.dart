import 'package:flutter/material.dart';

// ignore: must_be_immutable
class brandName extends StatelessWidget {
  String name;

  brandName({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(width: 5),
        Image.asset(
          'assets/icons/correct.png',
          width: 10,
          height: 10,
        ),
      ],
    );
  }
}
