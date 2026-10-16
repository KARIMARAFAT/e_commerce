import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:ecommerce_app_huma_volve/core/routes/app_routing.dart';
import 'package:ecommerce_app_huma_volve/core/routes/product_deep_link.dart';
import 'package:flutter/material.dart';

import 'core/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _linkSubscription = AppLinks().uriLinkStream.listen(
      _handleIncomingLink,
      onError: (Object error, StackTrace stackTrace) {
        debugPrint('Failed to receive app link: $error');
      },
    );
  }

  void _handleIncomingLink(Uri uri) {
    final route = productRouteFromUri(uri);
    if (route == null) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        appRouting.go(route);
      }
    });
  }

  @override
  void dispose() {
    unawaited(_linkSubscription?.cancel());
    super.dispose();
  }

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
