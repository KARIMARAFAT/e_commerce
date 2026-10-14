import 'package:ecommerce_app_huma_volve/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/usecases/get_products_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view/view_model/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUsecase getCategoriesUsecase;
  final GetProductsUsecase getProductsUsecase;
  HomeCubit({
    required this.getCategoriesUsecase,
    required this.getProductsUsecase,
  }) : super(HomeInitial());
  void loadHomeData() async {
    int categoryId = 0;
    emit(CategoriesLoading());

    final categories = await getCategoriesUsecase.invoke();
    categories.fold(
      (failure) {
        emit(CategoriesError(failure.failureMessage));
      },
      (categories) {
        categoryId = categories[0].id;
        emit(CategoriesSuccess(categories));
      },
    );

    final products = await getProductsUsecase.invoke(categoryId);
    products.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (products) {
        emit(ProductsSuccess(products));
      },
    );
  }

  Future<void> getProductsByCategory(int? categoryId) async {
    emit(ProductsLoading());
    final products = await getProductsUsecase.invoke(categoryId);
    products.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (products) {
        emit(ProductsSuccess(products));
      },
    );
  }
}
