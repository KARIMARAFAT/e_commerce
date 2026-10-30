import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/repository/cart_repository.dart';

class RemoveFromCartUsecase {
  final CartRepo repository;

  RemoveFromCartUsecase(this.repository);
  Future<Either<Failure, void>> invoke(
    int productId,
    String size,
    int colorValue,
  ) => repository.removeFromCart(productId, size, colorValue);
}
