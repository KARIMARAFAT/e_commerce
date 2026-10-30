import 'package:ecommerce_app_huma_volve/features/cart/data/data_source/cart_local_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/cart/data/models/cart_item_model.dart';
import 'package:hive/hive.dart';

class CartLocalDataSourceImp implements CartLocalDataSource {
  static const String _boxName = 'cartBox';

  Future<Box<CartItemModel>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<CartItemModel>(_boxName);
    }
    return Hive.box<CartItemModel>(_boxName);
  }

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final box = await _getBox();
    return box.values.toList();
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    final box = await _getBox();
    final key =
        '${item.productId}_${item.selectedSize}_${item.selectedColorValue}';

    // حفظ أو تحديث العنصر مباشرة بالكمية الممررة إليه (تجنب الجمع العشوائي)
    await box.put(key, item);
  }

  @override
  Future<void> removeFromCart(
    int productId,
    String size,
    int colorValue,
  ) async {
    final box = await _getBox();
    final key = '${productId}_${size}_$colorValue';
    await box.delete(key);
  }

  @override
  Future<void> clearCart() async {
    final box = await _getBox();
    await box.clear();
  }
}
