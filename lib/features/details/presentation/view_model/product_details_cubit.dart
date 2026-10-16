import 'package:ecommerce_app_huma_volve/features/details/domain/usecases/get_product_details_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/view_model/product_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUsecase getProductDetailsUseCase;

  ProductDetailsCubit(this.getProductDetailsUseCase)
    : super(ProductDetailsInitial());

  Future<void> fetchProductDetails(int productId) async {
    emit(ProductDetailsLoading());
    final result = await getProductDetailsUseCase.invoke(productId);
    result.fold(
      (failure) => emit(ProductDetailsError(message: failure.failureMessage)),
      (product) => emit(ProductDetailsLoaded(product: product)),
    );
  }
}
