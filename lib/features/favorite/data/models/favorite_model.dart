import 'package:hive/hive.dart';

import '../../../home/domain/entities/home_product_entity.dart';

@HiveType(typeId: 1) // استخدم typeId مختلف عن السلة (السلة كانت 0)
class FavoriteItemModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int price;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final String description;

  FavoriteItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
  });

  // التحويل من Model إلى Entity (استخدام HomeProductEntity مباشرة)
  HomeProductEntity toEntity() {
    return HomeProductEntity(
      id: id,
      title: title,
      price: price,
      images: [image],
      description: description,
      colors: [],
      sizes: [],
    );
  }

  // التحويل من Entity إلى Model
  factory FavoriteItemModel.fromEntity(HomeProductEntity product) {
    return FavoriteItemModel(
      id: product.id,
      title: product.title,
      price: product.price,
      image: product.images.isNotEmpty ? product.images.first : '',
      description: product.description,
    );
  }
}
