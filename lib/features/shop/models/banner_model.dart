// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String image;
  String id;
  BannerModel({
    required this.image,
    required this.id,
  });
  BannerModel.empty()
      : image = "",
        id = "";
  // Convert to json to store in FireStore
  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
      };

  // Map json to CateogryModel
  factory BannerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BannerModel(
        id: document.id,
        image: data['image'] ?? "",
      );
    } else {
      return BannerModel.empty(); 
    }
  }

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? "",
      image: json['image'] ?? "",
    );
  }
}
