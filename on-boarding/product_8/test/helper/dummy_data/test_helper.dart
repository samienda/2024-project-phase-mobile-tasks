import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:product_8/core/network/network_info.dart';
import 'package:product_8/features/Product/data/data_sources/local_data_source.dart';
import 'package:product_8/features/Product/data/data_sources/remote_data_source.dart';
import 'package:product_8/features/Product/domain/repositories/product_repository.dart';
import 'package:product_8/features/Product/domain/usecases/delete_product.dart';
import 'package:product_8/features/Product/domain/usecases/get_one_product.dart';
import 'package:product_8/features/Product/domain/usecases/get_products.dart';
import 'package:product_8/features/Product/domain/usecases/insert_product.dart';
import 'package:product_8/features/Product/domain/usecases/update_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([
  ProductRepository,
  ProductRemoteDataSource,
  InternetConnectionChecker,
  NetworkInfo,
  SharedPreferences,
  ProductLocalDataSource,
  GetOneProductUseCase,
  GetProductsUseCase,
  InsertProductUseCase,
  UpdateProductUseCase,
  DeleteProductUseCase,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
