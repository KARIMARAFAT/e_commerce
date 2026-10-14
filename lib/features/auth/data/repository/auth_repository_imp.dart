import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/core/storage/secure_storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/login_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/sign_up_response_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImp(this.authRemoteDataSource);
  @override
  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginModel = await authRemoteDataSource.login(
        email: email,
        password: password,
      );
      await SecureStorage.saveAccessToken(loginModel.accessToken);
      await SecureStorage.saveRefreshToken(loginModel.refreshToken);

      return right(loginModel);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, SignUpEntity>> signup(
    SignUpEntity signUpEntity,
  ) async {
    try {
      final signUpReModel = SignUpReModel(
        email: signUpEntity.email,
        password: signUpEntity.password,
        fullName: signUpEntity.name,
      );
      final responseModel = await authRemoteDataSource.signup(signUpReModel);
      await SecureStorage.saveUserData(responseModel);
      return right(responseModel);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
