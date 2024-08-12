import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:product_8/features/Product/domain/repositories/product_repository.dart';

@GenerateMocks([ProductRepository],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
