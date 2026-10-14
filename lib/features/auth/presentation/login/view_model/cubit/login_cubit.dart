import 'package:ecommerce_app_huma_volve/features/auth/domain/usecases/login_user_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/presentation/login/view_model/cubit/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUserUseCase loginUserUseCase;
  LoginCubit(this.loginUserUseCase) : super(LoginInitial());
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final loginModel = await loginUserUseCase.invoke(
      email: email,
      password: password,
    );
    loginModel.fold(
      (failure) {
        emit(LoginFailure(failure.failureMessage));
      },
      (loginModel) {
        emit(LoginSuccess(loginModel));
      },
    );
  }
}
