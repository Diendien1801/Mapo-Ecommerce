// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  int stock;
  double price;
  String title;
  double salePercentage;

  bool? isFeatured;
  String brand;
  String description;
  String? categoryId;
  String image;
  String productType;

  ProductModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.title,
    required this.salePercentage,
    this.isFeatured,
    required this.brand,
    required this.description,
    this.categoryId,
    required this.image,
    required this.productType,
  });

  static ProductModel empty() {
    return ProductModel(
      id: '',
      stock: 0,
      price: 0.0,
      title: '',
      salePercentage: 0.0,
      isFeatured: false,
      brand: '',
      description: '',
      categoryId: '',
      image: '',
      productType: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stock': stock,
      'price': price,
      'title': title,
      'salePercentage': salePercentage,
      'isFeatured': isFeatured,
      'brand': brand,
      'description': description,
      'categoryId': categoryId,
      'image': image,
      'productType': productType,
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      stock: data['stock'],
      price: data['price'],
      title: data['title'],
      salePercentage: data['salePercentage'],
      isFeatured: data['isFeatured'],
      brand: data['brand'],
      description: data['description'],
      categoryId: data['categoryId'],
      image: data['image'],
      productType: data['productType'],
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      stock: json['stock'],
      price: json['price'],
      title: json['title'],
      salePercentage: json['salePercentage'],
      isFeatured: json['isFeatured'],
      brand: json['brand'],
      description: json['description'],
      categoryId: json['categoryId'],
      image: json['image'],
      productType: json['productType'],
    );
  }
}
