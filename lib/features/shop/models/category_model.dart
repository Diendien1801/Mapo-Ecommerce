import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    required this.isFeatured,
  });

  static CategoryModel empty() =>
      CategoryModel(id: '', image: '', name: '', isFeatured: false);

  // Convert to json to store in FireStore
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'parentId': parentId,
        'isFeatured': isFeatured,
      };

  // Map json to CateogryModel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
          id: document.id,
          name: data['name'] ?? "",
          image: data['image'] ?? "",
          parentId: data['parentId'] ?? "",
          isFeatured: data['isFeatured'] ?? false);
    } else {
      return CategoryModel.empty();
    }
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      parentId: json['parentId'],
      isFeatured: json['isFeatured'],
    );
  }
}
