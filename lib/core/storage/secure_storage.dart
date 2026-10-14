import 'dart:convert';

import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/sign_up_response_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final storage = FlutterSecureStorage();
  static Future<void> saveAccessToken(String? token) async {
    await storage.write(key: 'access_token', value: token);
  }

  static Future<void> saveRefreshToken(String? token) async {
    await storage.write(key: 'refresh_token', value: token);
  }

  static Future<String?> getAccessToken() async {
    String? username = await storage.read(key: 'access_token');
    return username;
  }

  static Future<String?> getRefreshToken() async {
    String? username = await storage.read(key: 'refresh_token');
    return username;
  }

  static Future<void> deleteTokens() async {
    await storage.deleteAll();
  }

  static Future<void> saveUserData(SignUpEntity userEntity) async {
    final userMap = {
      'id': userEntity.id,
      'email': userEntity.email,
      'name': userEntity.name,
      'role': userEntity.role,
      'avatar': userEntity.avatar,
    };
    await storage.write(key: 'user_data', value: jsonEncode(userMap));
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final String? userJson = await storage.read(key: 'user_data');
    if (userJson != null) {
      return jsonDecode(userJson) as Map<String, dynamic>;
    }
    return null;
  }
}
