import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repositories/home_repository.dart';

class GetCategoriesUsecase {
  final HomeRepository homeRepository;

  GetCategoriesUsecase(this.homeRepository);
  Future<Either<Failure, List<HomeCategoryEntity>>> invoke() =>
      homeRepository.getCategories();
}
