import 'package:ecommerce_app_huma_volve/features/home/service/models/category_model.dart';
import 'package:flutter/material.dart';

class ProductModel {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  CategoryModel? category;
  List<String>? images;
  List<String> sizes = ['S', 'M', 'L'];

  List<Color> colors = [Colors.black, Colors.white, Colors.blue];
  ProductModel({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
    required this.colors,
    required this.sizes,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
  }
}
