import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store/common/widgets/brand_name/brand_name_with_icon.dart';
import 'package:store/common/widgets/button/add_to_cart_button.dart';
import 'package:store/common/widgets/icon/favorite_icon.dart';
import 'package:store/common/widgets/sale_tag/sale_tag.dart';
import 'package:store/features/shop/models/product_model.dart';
import 'package:store/features/shop/views/product_details/product_detail.dart';
import 'package:store/utils/effect/shimmer_effect.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
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
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration(
                    milliseconds: 400), // Customize transition duration
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return ProductDetailScreen(
                    productModel: product,
                  );
                },
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
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
            child: Hero(
              tag: product.id,
              child: CachedNetworkImage(
                imageUrl: product.image,
                placeholder: (context, url) =>
                    ShimmerEffect(width: 180, height: 180, radius: 20),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            // child: Image.network(
            //   product.image,
            //   fit: BoxFit.contain,
            //   loadingBuilder: (context, child, loadingProgress) =>
            //       loadingProgress == null
            //           ? child
            //           : Center(
            //               child: Column(
            //                 children: [
            //                   ShimmerEffect(
            //                       width: 180, height: 180, radius: 20),
            //                 ],
            //               ),
            //             ),
            // ),
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
          child: FavouriteIcon(productId: product.id),
        ),
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
