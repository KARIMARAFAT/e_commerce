import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/sign_up_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login({required String email, required String password});
  Future<SignUpResponseModel> signup(SignUpReModel signUpReModel);
}
