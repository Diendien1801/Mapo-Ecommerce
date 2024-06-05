import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundImage extends StatelessWidget {
  String img;
  double? height;
  double? width;
  double radius;
  Color color;
  RoundImage(
      {super.key,
      required this.img,
      required this.height,
      required this.width,
      required this.radius,
      required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
