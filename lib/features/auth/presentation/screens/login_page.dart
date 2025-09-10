import 'package:aktisada/core/constants/app_assets.dart';
import 'package:aktisada/core/constants/app_button.dart';
import 'package:aktisada/core/constants/app_dimens.dart';
import 'package:aktisada/core/constants/app_strings.dart';
import 'package:aktisada/core/constants/app_text_styles.dart';
import 'package:aktisada/core/utils/navigation_helper.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_event.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_state.dart';
import 'package:aktisada/features/dashboard/presentation/screens/dashboard_page.dart';
import 'package:aktisada/shared/widgets/app_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobileTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Prefill sample data only in debug mode
    if (kDebugMode) {
      mobileTextController.text = '9995051050';
      passwordTextController.text = '123456';
    }
  }

  @override
  void dispose() {
    mobileTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // if (_formKey.currentState!.validate()) {
    context.read<AuthBloc>().add(
      LoginRequested(
        mobile: mobileTextController.text.trim(),
        password: passwordTextController.text,
      ),
    );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            NavigationHelper.pushAndRemoveUntil(context, DashboardPage());
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: Dimens.pagePadding,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100.h),
                Center(
                  child: Image.asset(
                    AppAssets.images.logo,
                    height: 83.h,
                    width: 181.w,
                  ),
                ),
                SizedBox(height: 44.h),
                Text(
                  AppStrings.login.title,
                  style: AppTextStyles.base.w700.s27.l2,
                ),

                SizedBox(height: 12.h),
                Text(
                  AppStrings.login.description,
                  style: AppTextStyles.base.w500.s12.greyTextColor(),
                ),

                SizedBox(height: 32.h),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return AppFormField(
                      label: AppStrings.login.mobileFieldTitle,
                      controller: mobileTextController,
                      hintText: AppStrings.login.mobileFieldHint,
                      keyboardType: TextInputType.phone,
                      errorText: state is AuthValidationError
                          ? state.mobileError
                          : null,
                      onChanged: (value) {
                        if (state is AuthValidationError) {
                          context.read<AuthBloc>().add(ClearValidationErrors());
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 16.h),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return AppFormField(
                      label: AppStrings.login.passwordFieldTitle,
                      controller: passwordTextController,
                      isPassword: true,
                      hintText: AppStrings.login.passwordFieldHint,
                      errorText: state is AuthValidationError
                          ? state.passwordError
                          : null,
                      onChanged: (value) {
                        if (state is AuthValidationError) {
                          context.read<AuthBloc>().add(ClearValidationErrors());
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 24.h),

                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return AppButton.primary(
                      text: state is AuthLoading
                          ? 'Logging in...'
                          : AppStrings.login.button,
                      onPressed: state is AuthLoading ? null : _handleLogin,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
