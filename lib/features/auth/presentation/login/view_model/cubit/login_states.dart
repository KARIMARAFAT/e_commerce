import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/login_entity.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginEntity loginModel;
  LoginSuccess(this.loginModel);
}

class LoginFailure extends LoginState {
  final String errMessage;
  LoginFailure(this.errMessage);
}
