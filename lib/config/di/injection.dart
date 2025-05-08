import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:assignment/features/categories/data/datasources/category_remote_data_source.dart';
import 'package:assignment/features/categories/data/repositories/category_repository_impl.dart';
import 'package:assignment/features/categories/domain/repositories/category_repository.dart';
import 'package:assignment/features/categories/domain/usecases/get_categories.dart';
import 'package:assignment/features/categories/presentation/bloc/category_bloc.dart';
import 'package:assignment/features/products/data/datasources/product_remote_data_source.dart';
import 'package:assignment/features/products/data/repositories/product_repository_impl.dart';
import 'package:assignment/features/products/domain/repositories/product_repository.dart';
import 'package:assignment/features/products/domain/usecases/get_products_by_category.dart';
import 'package:assignment/features/products/presentation/bloc/product_bloc.dart';
import 'package:assignment/features/product_details/data/datasources/product_details_remote_data_source.dart';
import 'package:assignment/features/product_details/data/repositories/product_details_repository_impl.dart';
import 'package:assignment/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:assignment/features/product_details/domain/usecases/get_product_details.dart';
import 'package:assignment/features/product_details/presentation/bloc/product_details_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );
    dio.interceptors.add(CookieManager(CookieJar()));
    return dio;
  });

  // Data sources
  getIt.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<ProductDetailsRemoteDataSource>(
    () => ProductDetailsRemoteDataSourceImpl(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ProductDetailsRepository>(
    () => ProductDetailsRepositoryImpl(getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetCategories(getIt()));
  getIt.registerLazySingleton(() => GetProductsByCategory(getIt()));
  getIt.registerLazySingleton(() => GetProductDetails(getIt()));

  // Blocs
  getIt.registerFactory(() => CategoryBloc(getCategories: getIt()));
  getIt.registerFactory(() => ProductBloc(getProductsByCategory: getIt()));
  getIt.registerFactory(() => ProductDetailsBloc(getProductDetails: getIt()));
}
