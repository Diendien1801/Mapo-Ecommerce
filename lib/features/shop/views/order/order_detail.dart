// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:store/common/widgets/order_overview/order_overview.dart';
import 'package:store/common/widgets/product_item/item_card_horizontal.dart';

import 'package:store/features/shop/models/cart_item_model.dart';
import 'package:store/features/shop/models/order_model.dart';

// ignore: must_be_immutable
class OrderDetail extends StatelessWidget {
  OrderModel order;
 
  OrderDetail({
    super.key,
    required this.order,
    
  });

  @override
  Widget build(BuildContext context) {
    
    double totalCartPrice = 0;
    final cartItems = order.cartItems;
    cartItems.forEach(
        (element) => totalCartPrice += element.price * element.quantity);
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Order Detail',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery time
              Container(
                margin: const EdgeInsets.only(left: 24),
                child: Text(
                  'Expected delivery date: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              // Delivery address
              Container(
                margin: const EdgeInsets.all(20),
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Delivery Address: 123, XYZ Street, ABC City',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 24),
                child: Text(
                  'Order Items',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              // Order items
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                margin: const EdgeInsets.all(20),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: ItemCardHorizontal(
                              itemCart: cartItems[index],
                            ),
                          ),
                          Positioned(
                            right: 20,
                            top: 20,
                            child: Text(
                              'x ${cartItems[index].quantity}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Total price
              OrderOverview(
                totalCartPrice: totalCartPrice,
              ),
              // COntact
              Container(
                margin: const EdgeInsets.all(20),
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Icon(Icons.chat_bubble_outline),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            'Contact with Mapo',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                    // sub title
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Account, Payment, Delivery',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
