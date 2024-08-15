class Urls {
  static const String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v1';

  static String getOneProduct(String id) => '$baseUrl/products/$id';
  static String getProducts() => '$baseUrl/products';
  static String insertProduct() => '$baseUrl/products';
  static String updateProduct(String id) => '$baseUrl/products/$id';
  static String deleteProduct(String id) => '$baseUrl/products/$id';
}
