import 'package:get/get.dart';
import 'package:store/features/shop/controllers/cart_controller.dart';
import 'package:store/features/shop/models/cart_item_model.dart';
import 'package:store/naviga_menu.dart';
import 'package:store/utils/storage/storage_utility.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find<OrderController>();

  RxList<List<CartItemModel>> cartItemsInOrder = <List<CartItemModel>>[].obs;
  RxList<String> timeOrder = <String>[].obs;
  OrderController() {
    loadOrders();
  }
  void loadOrders() {
    // Load orders from the database
    List<dynamic>? cartItemsInOrderSub =
        MyLocalStorage.instance().readData<List<dynamic>>(
      'Orders',
    );
    if (cartItemsInOrderSub != null) {
      List<CartItemModel> flattenedList = [];
      for (var cartItemList in cartItemsInOrderSub) {
        for (var cartItem in cartItemList) {
          flattenedList.add(CartItemModel.fromJson(cartItem));
        }
        cartItemsInOrder.add(flattenedList);
        flattenedList = [];
      }

      List<dynamic>? data = MyLocalStorage.instance().readData<List<dynamic>>(
        'TimeOrder',
      );
      if (data != null) {
        timeOrder.assignAll(data.cast<String>());
      }
    }
    print(cartItemsInOrder.length);
  }

  void placeOrder() {
    final cartController = CartController.instance;
    final List<CartItemModel> tempList = cartController.cartItems.toList();
    if (cartController.cartItems.isNotEmpty) {
      cartItemsInOrder.add(tempList);
    }
    String date = getDate();
    timeOrder.add(date);
    cartController.clearCart();
    saveOrders();
    // Place order

    Get.snackbar('Thank you', 'Your order has been placed');
    Get.offAll(() => NavigationMenu());
  }

  void saveOrders() {
    // Save orders to the database
    List<List<Map<String, dynamic>>> jsonList =
        cartItemsInOrder.map((cartItemList) {
      return cartItemList.map((cartItem) {
        return cartItem.toJson();
      }).toList();
    }).toList();
    MyLocalStorage.instance().writeData(
      'Orders',
      jsonList,
    );
    MyLocalStorage.instance().writeData(
      'TimeOrder',
      timeOrder,
    );
  }

  void placeOrderForDetailCheckOut(CartItemModel cartItem) {
    var tempList = [cartItem];
    cartItemsInOrder.add(tempList);
    String date = getDate();
    timeOrder.add(date);
    saveOrders();
    print(cartItemsInOrder.length);
    Get.snackbar('Thank you', 'Your order has been placed');
    Get.offAll(() => NavigationMenu());
  }

  String getDate() {
    final DateTime now = DateTime.now();
    String? monthLetter = monthFormat[now.month];
    final String formattedDate = '${now.day} $monthLetter ${now.year}';
    return formattedDate;
  }

  String getShippingDate() {
    final DateTime now = DateTime.now();
    final DateTime shippingDate = now.add(const Duration(days: 3));
    String? monthLetter = monthFormat[shippingDate.month];
    final String formattedDate =
        '${shippingDate.day} $monthLetter ${shippingDate.year}';
    return formattedDate;
  }

  Map<int, String> monthFormat = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };
}
