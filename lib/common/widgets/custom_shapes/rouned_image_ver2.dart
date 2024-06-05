import 'package:flutter/widgets.dart';
import 'package:store/common/widgets/custom_shapes/rounded_image.dart';

class RoundImageOnline extends RoundImage {
  RoundImageOnline(
      {super.key,
      required super.img,
      required super.height,
      required super.width,
      required super.radius,
      required super.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
        image: DecorationImage(
          image: NetworkImage(img),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
