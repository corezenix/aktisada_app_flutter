import 'package:get_it/get_it.dart';

import '../core/services/local_storage_service.dart';
import '../features/auth/data/datasources/auth_remote_datasource.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
// Auth
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/get_user_usecase.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
// My Products
import '../features/my_products_list/presentation/bloc/my_products_bloc.dart';
import '../features/product/data/datasources/product_remote_datasource.dart';
import '../features/product/data/repositories/product_repository_impl.dart';
// Product
import '../features/product/domain/repositories/product_repository.dart';
import '../features/product/domain/usecases/apply_filter_usecase.dart';
import '../features/product/domain/usecases/get_products_usecase.dart';
import '../features/product/presentation/bloc/product_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core services - Initialize LocalStorageService first
  getIt.registerSingletonAsync<LocalStorageService>(
    () => LocalStorageService.getInstance(),
  );

  // Wait for LocalStorageService to be ready
  await getIt.isReady<LocalStorageService>();

  // Auth
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
      localStorageService: getIt(),
    ),
  );
  getIt.registerLazySingleton<LoginUsecase>(() => LoginUsecase(getIt()));
  getIt.registerLazySingleton<GetUserUsecase>(() => GetUserUsecase(getIt()));
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUsecase: getIt(),
      getUserUsecase: getIt(),
      localStorageService: getIt(),
    ),
  );

  // Product
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<GetProductsUsecase>(
    () => GetProductsUsecase(getIt()),
  );
  getIt.registerLazySingleton<ApplyFilterUsecase>(
    () => ApplyFilterUsecase(getIt()),
  );
  getIt.registerFactory<ProductBloc>(() => ProductBloc(repository: getIt()));

  // My Products
  getIt.registerFactory<MyProductsBloc>(
    () => MyProductsBloc(
      productRepository: getIt(),
      localStorageService: getIt(),
    ),
  );
}

// Extension to get blocs easily
extension GetItExtension on GetIt {
  AuthBloc get authBloc => get<AuthBloc>();
  ProductBloc get productBloc => get<ProductBloc>();
  MyProductsBloc get myProductsBloc => get<MyProductsBloc>();
}
