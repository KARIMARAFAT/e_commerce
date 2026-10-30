import 'package:ecommerce_app_huma_volve/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoadedState extends CartState {
  final List<CartItemEntity> items;
  final double subtotal;
  final double tax;
  final double total;
  CartLoadedState({
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.total,
  });
}

class CartErrorState extends CartState {
  final String message;
  CartErrorState(this.message);
}
