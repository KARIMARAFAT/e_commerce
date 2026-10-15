import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImp(this.homeRemoteDataSource);
  @override
  Future<Either<Failure, List<HomeCategoryEntity>>> getCategories() async {
    try {
      final categories = await homeRemoteDataSource.getCategories();
      return right(categories as List<HomeCategoryEntity>);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<HomeProductEntity>>> getProducts(
    int? categoryId, {
    required int limit,
    required int offset,
  }) async {
    try {
      final products = await homeRemoteDataSource.getProducts(
        categoryId,
        limit: limit,
        offset: offset,
      );
      return right(products as List<HomeProductEntity>);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
