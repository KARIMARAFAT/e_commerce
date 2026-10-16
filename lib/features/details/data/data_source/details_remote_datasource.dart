import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

abstract class DetailsRemoteDatasource {
  Future<HomeProductEntity> getProductDetails(int productId);
}
