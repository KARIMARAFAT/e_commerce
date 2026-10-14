import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/storage/secure_storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/sign_up_response_model.dart';
import 'package:flutter/material.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final ApiClient apiClient;
  AuthRemoteDataSourceImp(this.apiClient);
  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.loginEndPoint,
      data: {'email': email, 'password': password},
    );
    final jsonData = response.data;
    final data = LoginModel.fromJson(jsonData);
    await SecureStorage.saveAccessToken(data.accessToken);
    await SecureStorage.saveRefreshToken(data.refreshToken);
    debugPrint('AccessToken :${data.accessToken}');
    debugPrint('RefreshToken :${data.refreshToken}');

    return data;
  }

  @override
  Future<SignUpResponseModel> signup(SignUpReModel signUpReModel) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.signUpEndPoint,
      data: {
        'email': signUpReModel.email,
        'password': signUpReModel.password,
        'name': signUpReModel.fullName,
        'avatar': 'https://i.imgur.com/LDOO4Qs.jpg',
      },
    );
    final jsonData = response.data;
    final data = SignUpResponseModel.fromJson(jsonData);
    return data;
  }
}
