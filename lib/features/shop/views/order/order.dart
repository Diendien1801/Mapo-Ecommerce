import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/common/widgets/appbar/appbar.dart';
import 'package:store/features/shop/controllers/order_controller.dart';
import 'package:store/features/shop/views/order/order_detail.dart';
import 'package:store/utils/constants/colors.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final orderController = OrderController.instance;
    return FutureBuilder(
      future: orderController.fetchOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching orders'),
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  TAppBar(
                    leadingOnPressed: () => Navigator.pop(context),
                    leadingIcon: Icons.arrow_back_ios,
                    title: const Text('My Orders'),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: ListView.builder(
                      itemCount: orderController.orders.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 216, 213, 213),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => OrderDetail(
                                    order: orderController.orders[index]),
                              );
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.shopping_bag),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            orderController
                                                    .orders[index].isDelivered
                                                ? Text(
                                                    'Delivered',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .apply(
                                                          color:
                                                              TColors.primary,
                                                        ),
                                                  )
                                                : Text(
                                                    'Processing',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .apply(
                                                          color:
                                                              TColors.primary,
                                                        ),
                                                  ),
                                            Obx(
                                              () => Text(
                                                orderController
                                                    .orders[index].orderDate
                                                    .split(' ')
                                                    .first,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.discount),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Order',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ),
                                            Text(
                                              'ABCD${orderController.orders[index].orderId} ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 60),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.calendar_today),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Shipping Date',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                              ),
                                              Text(
                                                orderController
                                                    .orders[index].orderDate
                                                    .split(' ')
                                                    .first,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    //print(orderController.timeOrder.length);
  }
}
