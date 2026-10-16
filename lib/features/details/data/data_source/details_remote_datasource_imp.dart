import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/data_source/details_remote_datasource.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';
import 'package:flutter/material.dart';

class DetailsRemoteDatasourceImp implements DetailsRemoteDatasource {
  final ApiClient apiClient;
  DetailsRemoteDatasourceImp(this.apiClient);
  @override
  Future<HomeProductEntity> getProductDetails(int productId) async {
    final response = await apiClient.dio.get('products/$productId');
    final data = response.data;
    List<Color> parsedColors = [];
    if (data['colors'] != null) {
      parsedColors = (data['colors'] as List).map((colorHex) {
        return _parseColor(colorHex);
      }).toList();
    }
    List<String> parsedSizes = [];
    if (data['sizes'] != null) {
      parsedSizes = List<String>.from(data['sizes']);
    }
    List<String> parsedImages = [];
    if (data['images'] != null) {
      parsedImages = List<String>.from(data['images']);
    }
    return HomeProductEntity(
      id: data['id'] ?? productId,
      title: data['title'] ?? '',
      slug: data['slug'] ?? '',
      price: data['price'] ?? 0,
      description: data['description'] ?? '',
      images: parsedImages.isNotEmpty ? parsedImages : [],
      colors: parsedColors.isNotEmpty
          ? parsedColors
          : const [Colors.black, Colors.grey, Colors.blue],
      sizes: parsedSizes.isNotEmpty ? parsedSizes : const ['S', 'M', 'L', 'XL'],
    );
  }

  Color _parseColor(dynamic colorValue) {
    try {
      if (colorValue is int) {
        return Color(colorValue);
      } else if (colorValue is String) {
        String hex = colorValue.replaceAll('#', '');
        if (hex.length == 6) {
          hex = 'FF$hex';
        }
        return Color(int.parse(hex, radix: 16));
      }
    } catch (_) {}
    return Colors.grey;
  }
}
