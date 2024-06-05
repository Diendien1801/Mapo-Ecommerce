import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/common/widgets/custom_shapes/circular_container.dart';
import 'package:store/features/shop/controllers/banner_controller.dart';
import 'package:store/utils/constants/colors.dart';

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
                      child: Image.network(
                        i.image,
                        fit: BoxFit.cover,
                      ),
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
