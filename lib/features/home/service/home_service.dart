import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/service/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/service/models/product_model.dart';

class HomeService {
  final ApiClient apiclient;
  HomeService(this.apiclient);
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiclient.dio.get(ApiEndpoints.categoriesEndPoint);
    if (response.data == null || response.data.toString().isEmpty) {
      return [];
    }

    if (response.data is! List) {
      return [];
    }
    final List jsonData = response.data;
    final List<CategoryModel> categories = jsonData
        .map((e) => CategoryModel.fromJson(e))
        .toList();
    return categories;
  }

  Future<List<ProductModel>> getProducts(int? categoryId) async {
    final response = await apiclient.dio.get(
      "${ApiEndpoints.categoriesEndPoint}/$categoryId/${ApiEndpoints.productsEndPoint}",
    );

    if (response.data == null || response.data.toString().isEmpty) {
      return [];
    }

    if (response.data is! List) {
      return [];
    }

    final List jsonData = response.data;
    final List<ProductModel> products = jsonData
        .map((e) => ProductModel.fromJson(e))
        .toList();
    return products;
  }
}
