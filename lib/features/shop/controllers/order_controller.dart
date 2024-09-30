import 'package:get/get.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/data/repositories/order/oder_repository.dart';
import 'package:store/features/shop/controllers/cart_controller.dart';
import 'package:store/features/shop/models/cart_item_model.dart';
import 'package:store/features/shop/models/order_model.dart';
import 'package:store/naviga_menu.dart';
import 'package:store/utils/storage/storage_utility.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find<OrderController>();

  final orderRepository = Get.put(OrderRepository());
  RxList<OrderModel> orders = <OrderModel>[].obs;

  Future<void> fetchOrders() async {
    try {
      orders.value = await orderRepository.getOrders();
    } catch (e) {
      print(e);
    }
  }

  Future<void> placeOrder(OrderModel order) async {
    // Upload order to the API
    orderRepository.uploadOrder(OrderModel(
      userId: order.userId,
      orderId: order.orderId,
      orderDate: order.orderDate,
      cartItems: order.cartItems,
      isDelivered: false,
      shippingDate: order.shippingDate,
    ));
    // Clear the cart after placing the order
    CartController.instance.clearCart();

    // Show a snackbar to the user
    Get.snackbar('Thank you', 'Your order has been placed');
    Get.offAll(() => NavigationMenu());
  }

  
  void placeOrderForDetailCheckOut(OrderModel order) {
    // Upload order to the API
    orderRepository.uploadOrder(OrderModel(
      userId: order.userId,
      orderId: order.orderId,
      orderDate: order.orderDate,
      cartItems: order.cartItems,
      isDelivered: false,
      shippingDate: order.shippingDate,
    ));
    // Show a snackbar to the user
    Get.snackbar('Thank you', 'Your order has been placed');
    Get.offAll(() => NavigationMenu());
  }
}
