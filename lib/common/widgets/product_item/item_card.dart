import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/common/widgets/brand_name/brand_name_with_icon.dart';
import 'package:store/common/widgets/button/add_to_cart_button.dart';
import 'package:store/common/widgets/icon/favorite_icon.dart';
import 'package:store/common/widgets/sale_tag/sale_tag.dart';
import 'package:store/features/shop/controllers/favourite_controller.dart';
import 'package:store/features/shop/models/product_model.dart';
import 'package:store/features/shop/views/product_details/product_detail.dart';

class ItemCard extends StatelessWidget {
   ItemCard({
    super.key,
    required this.dark,
    required this.product,
  });
  final ProductModel product;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        Container(
          height: 300,
          width: 180,
          decoration: BoxDecoration(
            color: dark ? const Color.fromARGB(255, 2, 2, 2) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                        productModel: product,
                      )),
            );
          },
          child: Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              color:
                  dark ? Colors.grey : const Color.fromARGB(255, 245, 242, 242),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Image.network(
              product.image,
              fit: BoxFit.contain,
            ),
          ),
        ),

        // Information
        Positioned(
          top: 180,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Name
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10),
                child: Text(product.title,
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              // brand
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: brandName(name: product.brand),
              ),
              // PRICE
              Container(
                margin: const EdgeInsets.only(top: 30, left: 10),
                child: Text('\$${product.price}',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
            ],
          ),
        ),

        // favourite icon
        Positioned(
        right: 30,
        top: 14,
        child: FavouriteIcon(productId:product.id),),
        // BUTTON Add to cart
        Positioned(
          bottom: 0,
          right: 18,
          child: ProductCardAddToCartButton(product: product),
        ),
        const Positioned(
          top: 14,
          left: 10,
          child: SaleTag(),
        ),
      ],
    );
  }
}
