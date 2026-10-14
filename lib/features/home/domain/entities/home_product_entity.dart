import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_category_entity.dart';
import 'package:flutter/material.dart';

class HomeProductEntity {
  int id;
  String title;
  String slug;
  int price;
  String description;
  HomeCategoryEntity? category;
  List<String> images;
  List<String> sizes;
  List<Color> colors;
  HomeProductEntity({
    this.id = 0,
    this.title = '',
    this.slug = '',
    this.price = 0,
    this.description = '',
    this.category = const HomeCategoryEntity(),
    this.images = const [],
    this.colors = const [Colors.black, Colors.grey, Colors.blue],
    this.sizes = const ['S', 'M', 'L', 'XL'],
  });
}
