// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:store/common/widgets/brand_name/brand_name_with_icon.dart';
import 'package:store/features/shop/controllers/product_controller.dart';
import 'package:store/features/shop/models/brand_model.dart';

// ignore: must_be_immutable
class BrandCard extends StatelessWidget {
  BrandModel brandModel;
  bool? isFromInternet;
  Widget? child;

  BrandCard({
    super.key,
    required this.brandModel,
    this.child,
    this.isFromInternet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 107, 103, 103),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Image(
                  image: NetworkImage(brandModel.image)  ,
                  height: 40,
                  width: 40,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // NAME
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: brandName(name: brandModel.name),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      "256 products ...",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
          child ?? Container(),
        ],
      ),
    );
  }
}
