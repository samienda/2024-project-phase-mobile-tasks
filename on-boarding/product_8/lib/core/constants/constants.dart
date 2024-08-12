class Urls {
  static const String baseUrl = 'https://when known';

  static String getOneProduct(String id) => '$baseUrl/products/$id';
  static String getProducts() => '$baseUrl/products';
  static String insertProduct() => '$baseUrl/products';
  static String updateProduct(String id) => '$baseUrl/products/$id';
  static String deleteProduct(String id) => '$baseUrl/products/$id';
}
