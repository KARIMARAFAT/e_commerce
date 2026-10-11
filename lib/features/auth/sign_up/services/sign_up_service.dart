import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/sign_up_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/sign_up_response_model.dart';

class SignUpService {
  ApiClient apiClient;
  SignUpService(this.apiClient);
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
//https://api.escuelajs.co/api/v1/users
