import 'package:aktisada/core/constants/app_colors.dart';
import 'package:aktisada/core/network/api_client.dart';
import 'package:aktisada/di/injector.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aktisada/features/auth/presentation/screens/splash_page.dart';
import 'package:aktisada/features/my_products_list/presentation/bloc/my_products_bloc.dart';
import 'package:aktisada/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize API client interceptors
    ApiClient.setupInterceptors();

    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (context) => getIt.authBloc),
            BlocProvider<ProductBloc>(create: (context) => getIt.productBloc),
            BlocProvider<MyProductsBloc>(
              create: (context) => getIt.myProductsBloc,
            ),
          ],
          child: MaterialApp(
            title: 'Calicult',
            home: const SplashPage(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primaryColor: AppColors.primary,
              fontFamily: GoogleFonts.poppins().fontFamily,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: AppColors.primary,
                secondary: AppColors.primary,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
          ),
        );
      },
    );
  }
}
