import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/common/widgets/custom_shapes/circular_container.dart';
import 'package:store/features/shop/controllers/banner_controller.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/effect/shimmer_effect.dart';

class BannerCustom extends StatelessWidget {
  const BannerCustom({super.key});
  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(HomeController());
    final controller = Get.put(BannerController());
    return Column(
      children: [
        // -- BANNER

        Obx(
          () => Container(
            margin: const EdgeInsets.only(top: 20),
            child: CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  controller.changeIndex(index);
                },
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: controller.monthlyBanners.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                      ),
                      child: CachedNetworkImage(
                          imageUrl: i.image,
                          placeholder: (context, url) => ShimmerEffect(
                                width: 400,
                                height: 170,
                              ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                      // child: Image.network(
                      //   i.image,
                      //   fit: BoxFit.cover,
                      //   loadingBuilder: (context, child, loadingProgress) =>
                      //       loadingProgress == null
                      //           ? child
                      //           : Center(
                      //               child: Column(
                      //                 children: [
                      //                   ShimmerEffect(
                      //                       width: 400,
                      //                       height: 170,
                      //                       radius: 20),
                      //                 ],
                      //               ),
                      //             ),
                      // ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
        Obx(() => Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++)
                    CircularContainer(
                      height: 4,
                      width: 20,
                      margin: 5,
                      backgroundColor:
                          controller.carousalCurrentIndex.value == i
                              ? TColors.primary
                              : Colors.grey,
                    ),
                ],
              ),
            ))
      ],
    );
  }
}
