import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/features/shop/models/cart_item_model.dart';

class OrderModel {
  String userId;
  String orderId;
  String orderDate;
  List<CartItemModel> cartItems;
  bool isDelivered;
  String shippingDate;

  OrderModel({
    required this.userId,
    required this.orderId,
    required this.orderDate,
    required this.cartItems,
    required this.isDelivered,
    required this.shippingDate,
  });

  OrderModel.empty()
      : userId = '',
        orderId = '',
        orderDate = '',
        cartItems = [],
        shippingDate = '',
        isDelivered = false;
        
  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return OrderModel(
        userId: data['userId'],
        orderId: data['orderId'],
        orderDate: data['orderDate'],
        cartItems: (data['cartItems'] as List)
            .map((e) => CartItemModel.fromJson(e))
            .toList(),
        isDelivered: data['isDelivered'],
        shippingDate: data['shippingDate'],
      );
    } else {
      return OrderModel.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orderId': orderId,
      'orderDate': orderDate,
      'cartItems': cartItems.map((e) => e.toJson()).toList(),
      'isDelivered': isDelivered,
      'shippingDate': shippingDate,
    };
  }
}
