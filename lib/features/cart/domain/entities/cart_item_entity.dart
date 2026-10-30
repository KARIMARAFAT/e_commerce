import 'package:flutter/material.dart';

import '../../../home/domain/entities/home_product_entity.dart';

class CartItemEntity {
  final HomeProductEntity product;
  final String selectedSize;
  final Color selectedColor;
  int quantity;

  CartItemEntity({
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    this.quantity = 1,
  });
}
