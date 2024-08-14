import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:product_8/core/network/network_info.dart';
import 'package:product_8/features/Product/data/data_sources/remote_data_source.dart';
import 'package:product_8/features/Product/domain/repositories/product_repository.dart';

@GenerateMocks([
  ProductRepository,
  ProductRemoteDataSource,
  InternetConnectionChecker,
  NetworkInfo,
],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
