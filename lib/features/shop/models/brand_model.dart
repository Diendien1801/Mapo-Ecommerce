import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.productsCount,
  });

  static BrandModel empty() =>
      BrandModel(id: '', name: '', image: '', isFeatured: false);

  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BrandModel(
          id: data['id'] ?? '',
          name: data['name'] ?? "",
          image: data['image'] ?? '',
          isFeatured: data['isFeatured']);
    } else {
      return BrandModel.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
    };
  }
}
