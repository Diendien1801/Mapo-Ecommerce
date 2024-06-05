import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';

class CircularContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? padding;
  final double radius;
  final Widget? child;
  final Color backgroundColor;
  final double? margin;
  const CircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.padding = 0,
    this.radius = 400,
    this.margin = 0,
    this.child,
    this.backgroundColor = TColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.only(
        right: margin!,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
    );
  }
}
