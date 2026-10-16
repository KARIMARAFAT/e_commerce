String? productRouteFromUri(Uri uri) {
  final isSupportedLink =
      (uri.scheme == 'humavolve' && uri.host == 'app') ||
      (uri.scheme == 'https' && uri.host == 'autoswift-c3d18.web.app');
  if (!isSupportedLink) {
    return null;
  }

  final pathSegments = uri.pathSegments;
  if (pathSegments.length != 2 || pathSegments.first != 'products') {
    return null;
  }

  final productId = int.tryParse(pathSegments[1]);
  if (productId == null || productId <= 0) {
    return null;
  }

  return '/products/$productId';
}
