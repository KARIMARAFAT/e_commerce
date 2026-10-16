import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/data_source/details_remote_datasource.dart';
import 'package:ecommerce_app_huma_volve/features/details/domain/repository/product_details_repository.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

class ProductDetailsRepoImp implements ProductDetailsRepository {
  final DetailsRemoteDatasource detailsRemoteDatasource;
  ProductDetailsRepoImp(this.detailsRemoteDatasource);
  @override
  Future<Either<Failure, HomeProductEntity>> getProductDetails(
    int productId,
  ) async {
    try {
      final product = await detailsRemoteDatasource.getProductDetails(
        productId,
      );
      return Right(product);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
