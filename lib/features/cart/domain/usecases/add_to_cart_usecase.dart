import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/repository/cart_repository.dart';

import '../../../../core/failure/failure.dart';

class AddToCartUsecase {
  final CartRepo repository;
  AddToCartUsecase(this.repository);

  Future<Either<Failure, void>> invoke(CartItemEntity item) =>
      repository.addToCart(item);
}
