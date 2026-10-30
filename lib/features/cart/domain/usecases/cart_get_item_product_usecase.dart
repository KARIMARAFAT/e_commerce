import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/repository/cart_repository.dart';

import '../../../../core/failure/failure.dart';

class GetCartItemsUsecase {
  final CartRepo repository;
  GetCartItemsUsecase(this.repository);

  Future<Either<Failure, List<CartItemEntity>>> invoke() =>
      repository.getCartItems();
}
