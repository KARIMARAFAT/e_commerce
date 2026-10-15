import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/usecases/get_products_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view/view_model/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUsecase getCategoriesUsecase;
  final GetProductsUseCase getProductsUsecase;

  final List<HomeProductEntity> products = [];
  int limit = 10;
  int offset = 0;
  bool isLoadingMore = false;
  bool hasMore = true;
  int? selectedCategory;

  HomeCubit({
    required this.getCategoriesUsecase,
    required this.getProductsUsecase,
  }) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(CategoriesLoading());
    int id = 0;
    final categoriesResult = await getCategoriesUsecase.invoke();
    categoriesResult.fold(
      (failure) {
        emit(CategoriesError(failure.failureMessage));
      },
      (categoriesList) {
        id = categoriesList.first.id;
        emit(CategoriesSuccess(categoriesList));
      },
    );

    await getProductsByCategory(id);
  }

  Future<void> getProductsByCategory(int categoryId) async {
    emit(ProductsLoading());
    hasMore = true;
    selectedCategory = categoryId;
    products.clear();
    final result = await getProductsUsecase.invoke(
      categoryId,
      limit: limit,
      offset: offset,
    );
    result.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (newProducts) {
        products.addAll(newProducts);
        offset = products.length;
        if (newProducts.length < limit) {
          hasMore = false;
        }

        emit(ProductsSuccess(List.from(products)));
      },
    );
  }

  Future<void> loadMoreData() async {
    if (isLoadingMore || !hasMore || selectedCategory == null) return;
    isLoadingMore = true;
    emit(ProductsLoadingMore());
    final result = await getProductsUsecase.invoke(
      selectedCategory,
      limit: limit,
      offset: offset,
    );
    result.fold(
      (failure) {
        emit(ProductsLoadingError(failure.failureMessage));
      },
      (newProducts) {
        products.addAll(newProducts);
        offset += products.length;
        if (newProducts.length < limit) {
          hasMore = false;
        }
        emit(ProductsSuccess(products));
      },
    );
  }
}
