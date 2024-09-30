import 'package:get/get.dart';
import 'package:store/features/shop/models/cart_item_model.dart';
import 'package:store/features/shop/models/product_model.dart';
import 'package:store/naviga_menu.dart';
import 'package:store/utils/storage/storage_utility.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find<CartController>();

  // Variables
  RxInt noOfCartItems = 0.obs; // number of items in the cart
  RxDouble totalCartPrice = 0.0.obs; // total price of the cart
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  CartController() {
    loadCartItems();
  }
  // Add items in the cart ( Add to cart button with quantity)
  void addToCart(ProductModel product) {
    // Check quantity
    if (productQuantityInCart.value < 1) {
      Get.snackbar('', 'Please, select quantity');
      return;
    }

    // Convert the ProductModel to CartItemModel
    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);

    // check if the product is already in the cart
    int index = cartItems.indexWhere(
        (element) => element.productId == selectedCartItem.productId);

    if (index >= 0) {
      // this quantity is already added or Updated/Removed the cart
      cartItems[index].quantity += selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    Get.snackbar('Thank you', 'Your product has been added to the cart');
  }

  /// Convert ProductModel to CartItemModel
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: product.price,
      image: product.image,
      quantity: quantity,
      brandName: product.brand,
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;
    for (var item in cartItems) {
      calculatedTotalPrice += item.price * item.quantity;
      calculatedNoOfItems += item.quantity;
    }
    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    MyLocalStorage.instance().writeData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings = MyLocalStorage.instance().readData<List<dynamic>>(
      'cartItems',
    );
    // check if the cartItemStrings is not null -> convert it to CartItemModel
    if (cartItemStrings != null) {
      cartItems.value = cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList();
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    // 
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems
        .indexWhere((cartItem) => cartItem.productId == item.productId);
    // if the item is already in the cart
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems
        .indexWhere((cartItem) => cartItem.productId == item.productId);
    if (index >= 0) {
      cartItems[index].quantity -= 1;
      if (cartItems[index].quantity == 0) {
        cartItems.removeAt(index);
      }
    }
    updateCart();
  }

  void addProductQuantityInCart() {
    productQuantityInCart.value += 1;
  }

  void removeProductQuantityInCart() {
    productQuantityInCart.value -= 1;
    if (productQuantityInCart.value < 0) {
      productQuantityInCart.value = 0;
    }
  }

  void placeOrder() {
    // Place order logic
    //clearCart();
    Get.snackbar('Done!', 'Thank you for your order!');
    Get.offAll(() => NavigationMenu());
  }
}
