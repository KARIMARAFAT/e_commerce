import 'package:ecommerce_app_huma_volve/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int price;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final String selectedSize;

  @HiveField(5)
  final int selectedColorValue;

  @HiveField(6)
  int quantity;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.selectedSize,
    required this.selectedColorValue,
    required this.quantity,
  });

  CartItemEntity toEntity() {
    return CartItemEntity(
      product: HomeProductEntity(
        id: productId,
        title: title,
        price: price,
        images: [image],
      ),
      selectedSize: selectedSize,
      selectedColor: Color(selectedColorValue),
      quantity: quantity,
    );
  }

  factory CartItemModel.fromEntity(CartItemEntity item) {
    return CartItemModel(
      productId: item.product.id,
      title: item.product.title,
      price: item.product.price,
      image: item.product.images.isNotEmpty ? item.product.images.first : '',
      selectedSize: item.selectedSize,
      selectedColorValue: item.selectedColor.value,
      quantity: item.quantity,
    );
  }
}
