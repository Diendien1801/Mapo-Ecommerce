import 'package:flutter/material.dart';
import 'package:store/common/widgets/appbar/appbar.dart';
import 'package:store/common/widgets/product_item/item_card_horizontal.dart';
import 'package:store/utils/constants/colors.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: TColors.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            'Place Order',
            style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: TColors.white,
                ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TAppBar(
              leadingOnPressed: () => Navigator.pop(context),
              leadingIcon: Icons.arrow_back_ios,
              title: Text(
                'Order Review',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            // -- ORDER SUMMARY
            Container(
              height: 200,
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    // child: const ItemCardHorizontal(),
                  );
                },
              ),
            ),

            // --COUNPON
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      'Have a promo code? Enter here',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 40,
                      width: 80,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: TColors.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Apply',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // -- TOTAL
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    child: ListTile(
                      title: Text(
                        'Subtotal',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: Text(
                        '\$ 100',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: ListTile(
                      title: Text(
                        'Shipping Fee',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: Text(
                        '\$ 10',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: ListTile(
                      title: Text(
                        'Tax Fee',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: Text(
                        '\$ 10',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: ListTile(
                      title: Text(
                        'Total',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      trailing: Text(
                        '\$ 120',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40, right: 20, left: 20),
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  // PAYMENT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              'Payment Method',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, right: 20),
                            child: Text(
                              'Change',
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.apply(
                                        color: TColors.primary,
                                      ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 40, top: 10),
                        child: Image.asset(
                          'assets/logos/visa.png',
                          height: 50,
                          width: 50,
                        ),
                      )
                    ],
                  ),

                  // ADDRESS
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              'Shipping Address',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, right: 20),
                            child: Text(
                              'Change',
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.apply(
                                        color: TColors.primary,
                                      ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          '1234 Main Street, New York, NY 10001',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
