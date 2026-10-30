import 'package:ecommerce_app_huma_volve/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/usecases/cart_get_item_product_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import 'cart_states.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItemsUsecase getCartItemsUsecase;
  final AddToCartUsecase addToCartUsecase;
  final RemoveFromCartUsecase removeFromCartUsecase;
  final ClearCartUsecase clearCartUsecase; // <--- حقن UseCase مسح السلة

  CartCubit({
    required this.getCartItemsUsecase,
    required this.addToCartUsecase,
    required this.removeFromCartUsecase,
    required this.clearCartUsecase,
  }) : super(CartInitial());

  Future<void> fetchCartItems() async {
    emit(CartLoading());
    final result = await getCartItemsUsecase.invoke();

    result.fold(
      (failure) => emit(CartErrorState(failure.failureMessage)),
      (items) => _calculateAndEmit(items),
    );
  }

  Future<void> addToCart(CartItemEntity item) async {
    final result = await addToCartUsecase.invoke(item);

    result.fold(
      (failure) => emit(CartErrorState(failure.failureMessage)),
      (_) => fetchCartItems(),
    );
  }

  Future<void> removeFromCart(
    int productId,
    String size,
    int colorValue,
  ) async {
    final result = await removeFromCartUsecase.invoke(
      productId,
      size,
      colorValue,
    );

    result.fold(
      (failure) => emit(CartErrorState(failure.failureMessage)),
      (_) => fetchCartItems(),
    );
  }

  // دالة مسح السلة بالكامل
  Future<void> clearCart() async {
    final result = await clearCartUsecase.invoke();

    result.fold(
      (failure) => emit(CartErrorState(failure.failureMessage)),
      (_) => fetchCartItems(), // إعادة جلب العناصر لتصبح السلة فارغة وتتحدث الواجهة
    );
  }

  void _calculateAndEmit(List<CartItemEntity> items) {
    double subtotal = items.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
    double tax = subtotal * 0.1;
    double total = subtotal + tax;

    emit(
      CartLoadedState(items: items, subtotal: subtotal, tax: tax, total: total),
    );
  }
}
