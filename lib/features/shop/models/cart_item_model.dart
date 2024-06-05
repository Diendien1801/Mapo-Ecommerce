class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String? brandName;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.price,
    this.image,
    required this.quantity,
    this.brandName,
  });

  // Empty Cart Item
  static CartItemModel empty = CartItemModel(
    productId: '',
    title: '',
    price: 0.0,
    quantity: 0,
  );

  // Convert to Json
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'brandName': brandName,
    };
  }

  // Create Cart Item from Json
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      title: json['title'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
      brandName: json['brandName'],
    );
  }
}
