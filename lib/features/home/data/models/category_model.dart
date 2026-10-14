import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_category_entity.dart';

class CategoryModel extends HomeCategoryEntity {
  const CategoryModel({super.id, super.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['id'], name: json['name']);
  }
}
