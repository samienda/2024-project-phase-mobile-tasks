class Product {
  final String name;
  final String catagory;
  final double price;
  final String description;

  const Product(
    this.name,
    this.catagory,
    this.price,
    this.description,
  );
}

List<Product> products = [
  Product( 'T-Shirt', 'Clothing', 19.99, 'A comfortable cotton t-shirt'),
  Product('Jeans', 'Clothing', 49.99, 'Stylish blue jeans'),
  Product('Jacket', 'Clothing', 89.99, 'Warm winter jacket'),
  Product('Sneakers', 'Clothing', 59.99, 'Casual sneakers for everyday wear'),
  Product('Hat', 'Clothing', 14.99, 'A trendy baseball cap'),
];
