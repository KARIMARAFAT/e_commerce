import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/details/domain/repository/product_details_repository.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

class GetProductDetailsUsecase {
  final ProductDetailsRepository productDetailsRepository;
  GetProductDetailsUsecase(this.productDetailsRepository);
  Future<Either<Failure, HomeProductEntity>> invoke(int productId) =>
      productDetailsRepository.getProductDetails(productId);
}
