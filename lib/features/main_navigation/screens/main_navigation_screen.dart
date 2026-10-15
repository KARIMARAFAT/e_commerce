import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/storage/secure_storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/sign_up_response_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source_imp.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repository/home_repository_imp.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repositories/home_repository.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/usecases/get_products_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme.dart';
import '../../home/presentation/view/home_screen.dart';
import '../../cart/screens/cart_screen.dart';
import '../../profile/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  late final ApiClient apiClient;
  late final HomeRemoteDataSource homeRemoteDataSource;
  late final HomeRepository homeRepository;
  late final GetCategoriesUsecase getCategoriesUsecase;
  late final GetProductsUseCase getProductsUsecase;
  late final HomeCubit homeCubit;

  final Future<Map<String, dynamic>?> _userDataFuture =
      SecureStorage.getUserData();
  @override
  void initState() {
    super.initState();
    apiClient = ApiClient();
    homeRemoteDataSource = HomeRemoteDataSourceImp(apiClient);
    homeRepository = HomeRepositoryImp(homeRemoteDataSource);
    getCategoriesUsecase = GetCategoriesUsecase(homeRepository);
    getProductsUsecase = GetProductsUseCase(homeRepository);

    homeCubit = HomeCubit(
      getCategoriesUsecase: getCategoriesUsecase,
      getProductsUsecase: getProductsUsecase,
    );
  }

  @override
  void dispose() {
    homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _userDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final userData = snapshot.data;
        final parsedId = userData != null && userData['id'] != null
            ? (userData['id'] is int
                  ? userData['id']
                  : int.tryParse(userData['id'].toString()) ?? 0)
            : 0;

        final signUpEntity = SignUpEntity(
          id: parsedId,
          name: userData?['name'] ?? 'Guest User',
          email: userData?['email'] ?? 'guest@ecommerce.com',
          role: userData?['role'] ?? 'user',
          avatar: userData?['avatar'] ?? '',
        );

        final List<Widget> screens = [
          BlocProvider.value(value: homeCubit, child: const HomeScreen()),
          const CartScreen(),
          ProfileScreen(signUpEntity: signUpEntity),
        ];

        return Scaffold(
          body: IndexedStack(index: _currentIndex, children: screens),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                backgroundColor: Colors.white,
                selectedItemColor: AppTheme.primary,
                unselectedItemColor: Colors.grey.shade400,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(Icons.home_filled, size: 28),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(Icons.home_filled, size: 32),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(Icons.shopping_cart_outlined, size: 28),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(Icons.shopping_cart, size: 32),
                    ),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(Icons.person_outline, size: 28),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(Icons.person, size: 32),
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
