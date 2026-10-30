import 'package:ecommerce_app_huma_volve/core/routes/app_routing.dart';
import 'package:ecommerce_app_huma_volve/features/cart/data/data_source/cart_local_data_source_imp.dart';
import 'package:ecommerce_app_huma_volve/features/cart/data/repository/cart_repository_imp.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/usecases/cart_get_item_product_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/cart/data/models/cart_item_model.dart';
// استيراد طبقات السلة (Cart Feature)

import 'features/cart/domain/usecases/add_to_cart_usecase.dart';

import 'features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'features/cart/presentation/view_model/cart_cubit.dart';

import 'core/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(CartItemModelAdapter());
  }
  final cartLocalDataSource = CartLocalDataSourceImp();
  final cartRepo = CartRepoImp(cartLocalDataSource);
  final getCartItemsUsecase = GetCartItemsUsecase(cartRepo);
  final addToCartUsecase = AddToCartUsecase(cartRepo);
  final removeFromCartUsecase = RemoveFromCartUsecase(cartRepo);
  final clearCartUsecase = ClearCartUsecase(cartRepo);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(
            getCartItemsUsecase: getCartItemsUsecase,
            addToCartUsecase: addToCartUsecase,
            removeFromCartUsecase: removeFromCartUsecase,
            clearCartUsecase: clearCartUsecase,
          )..fetchCartItems(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouting,
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    );
  }
}
