import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../repository/cart_repository.dart';

class ClearCartUsecase {
  final CartRepo repository;

  ClearCartUsecase(this.repository);

  Future<Either<Failure, void>> invoke() => repository.clearCart();
}
