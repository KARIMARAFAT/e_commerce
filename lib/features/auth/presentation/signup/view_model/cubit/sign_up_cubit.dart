import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/sign_up_response_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/usecases/sign_up_user_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/auth/presentation/signup/view_model/cubit/sign_up_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUserUsecase signUpUserUsecase;
  SignUpCubit(this.signUpUserUsecase) : super(SignUpInitial());
  Future<void> signup(SignUpEntity signUpEntity) async {
    emit(SignUpLoading());
    final result = await signUpUserUsecase.invoke(signUpEntity);
    result.fold(
      (failure) => emit(SignUpFailure(failure.failureMessage)),
      (userEntity) => emit(SignUpSuccess(userEntity)),
    );
  }
}
