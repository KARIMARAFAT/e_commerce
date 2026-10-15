import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/sign_up_response_entity.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final SignUpEntity signUpResponseModel;
  SignUpSuccess(this.signUpResponseModel);
}

class SignUpFailure extends SignUpState {
  final String errMessage;
  SignUpFailure(this.errMessage);
}
