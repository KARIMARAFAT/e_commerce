import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/entities/cart_item_entity.dart';

import '../../../../core/failure/failure.dart';

abstract class CartRepo {
  Future<Either<Failure, List<CartItemEntity>>> getCartItems();
  Future<Either<Failure, void>> addToCart(CartItemEntity item);
  Future<Either<Failure, void>> removeFromCart(
    int productId,
    String size,
    int colorValue,
  );
  Future<Either<Failure, void>> clearCart();
}
