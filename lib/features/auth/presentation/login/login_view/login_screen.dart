import 'package:ecommerce_app_huma_volve/core/helper/snack.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/theme.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/primary_button.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_source/auth_remote_data_source_imp.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/repository/auth_repository_imp.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repository/auth_repository.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/usecases/login_user_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/presentation/login/view_model/cubit/login_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/auth/presentation/login/view_model/cubit/login_states.dart';
import 'package:ecommerce_app_huma_volve/features/main_navigation/screens/main_navigation_screen.dart';
import 'package:ecommerce_app_huma_volve/features/auth/presentation/signup/signup_view/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final LoginUserUseCase loginUserUseCase;
  late final AuthRepository authRepository;
  late final AuthRemoteDataSource authRemoteDataSource;
  late final ApiClient apiClient;
  late final LoginCubit loginCubit;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    apiClient = ApiClient();
    authRemoteDataSource = AuthRemoteDataSourceImp(apiClient);
    authRepository = AuthRepositoryImp(authRemoteDataSource);
    loginUserUseCase = LoginUserUseCase(authRepository);
    loginCubit = LoginCubit(loginUserUseCase);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginCubit,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                showsnackbar(context, Colors.green, 'Logged in successfully');
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainNavigationScreen(),
                  ),
                );
              } else if (state is LoginFailure) {
                showsnackbar(context, Colors.red, state.errMessage);
              }
            },
            builder: (context, state) {
              final isLoading = state is LoginLoading;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 60),
                      Icon(
                        Icons.shopping_bag,
                        size: 80,
                        color: AppTheme.primary,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Welcome Back!',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(fontSize: 32),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Login to continue your shopping',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 64),
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        isLoading: isLoading,
                        text: 'Login',
                        onPressed: isLoading
                            ? () {}
                            : () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<LoginCubit>().login(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                }
                              },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
