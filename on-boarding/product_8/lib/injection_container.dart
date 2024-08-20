import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/Product/data/data_sources/local_data_source.dart';
import 'features/Product/data/data_sources/remote_data_source.dart';
import 'features/Product/data/repositories/product_repository_impl.dart';
import 'features/Product/domain/repositories/product_repository.dart';
import 'features/Product/domain/usecases/delete_product.dart';
import 'features/Product/domain/usecases/get_one_product.dart';
import 'features/Product/domain/usecases/get_products.dart';
import 'features/Product/domain/usecases/insert_product.dart';
import 'features/Product/domain/usecases/update_product.dart';
import 'features/Product/presentation/bloc/product_bloc.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  //bloc
  locator.registerFactory(() => ProductBloc(
        getProductsUseCase: locator(),
        getOneProductUseCase: locator(),
        insertProductUseCase: locator(),
        updateProductUseCase: locator(),
        deleteProductUseCase: locator(),
      ));

  // usecase
  locator.registerLazySingleton(
    () => GetProductsUseCase(productRepository: locator()),
  );

  locator.registerLazySingleton(
    () => GetOneProductUseCase(productRepository: locator()),
  );

  locator.registerLazySingleton(
    () => UpdateProductUseCase(productRepository: locator()),
  );

  locator.registerLazySingleton(
    () => InsertProductUseCase(productRepository: locator()),
  );

  locator.registerLazySingleton(
    () => DeleteProductUseCase(productRepository: locator()),
  );

  // repository
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      productRemoteDataSource: locator(),
      productLocalDataSourcel: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: locator()),
  );

  locator.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: locator()),
  );

  // core
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnectionChecker: locator()),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => InternetConnectionChecker());
}
