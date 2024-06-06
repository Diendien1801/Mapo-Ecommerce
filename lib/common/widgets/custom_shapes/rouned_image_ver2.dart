import 'package:flutter/widgets.dart';
import 'package:store/common/widgets/custom_shapes/rounded_image.dart';
import 'package:store/utils/effect/shimmer_effect.dart';

// ignore: must_be_immutable
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
        ),
        child: Image.network(
          img,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) =>
              loadingProgress == null
                  ? child
                  : Center(
                      child: Column(
                        children: [
                          ShimmerEffect(width: 180, height: 100, radius: 20),
                        ],
                      ),
                    ),
        ));
  }
}
