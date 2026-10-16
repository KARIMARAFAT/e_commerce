import 'package:ecommerce_app_huma_volve/core/routes/product_deep_link.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('productRouteFromUri', () {
    test('handles the website product URL', () {
      expect(
        productRouteFromUri(
          Uri.parse('https://autoswift-c3d18.web.app/products/12'),
        ),
        '/products/12',
      );
    });

    test('handles the app return URL', () {
      expect(
        productRouteFromUri(Uri.parse('humavolve://app/products/12')),
        '/products/12',
      );
    });

    test('rejects unsupported and invalid URLs', () {
      expect(
        productRouteFromUri(Uri.parse('https://example.com/products/12')),
        isNull,
      );
      expect(
        productRouteFromUri(
          Uri.parse('humavolve://app/products/not-a-number'),
        ),
        isNull,
      );
      expect(
        productRouteFromUri(Uri.parse('humavolve://app/products/0')),
        isNull,
      );
    });
  });
}
