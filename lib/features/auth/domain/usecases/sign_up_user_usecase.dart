import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/sign_up_response_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repository/auth_repository.dart';

class SignUpUserUsecase {
  final AuthRepository authRepository;
  SignUpUserUsecase(this.authRepository);
  Future<Either<Failure, SignUpEntity>> invoke(SignUpEntity signUpEntity) =>
      authRepository.signup(signUpEntity);
}
