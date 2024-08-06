import 'dart:io';

void main() {
  Product product1 = Product("Product 1", "Description 1", 10.0);
  Product product2 = Product("Product 2", "Description 2", 20.0);
  Product product3 = Product("Product 3", "Description 3", 30.0);

  ProductManager productManager = ProductManager();
  productManager.addNewProduct(product1);
  productManager.addNewProduct(product2);
  productManager.addNewProduct(product3);

  void responseAdd() {
    try {
      stdout.writeln('product name');
      final productName = stdin.readLineSync();
      stdout.writeln('product description');
      final productDescription = stdin.readLineSync();
      stdout.writeln('product price');
      final productPrice = stdin.readLineSync();
      if (productPrice != null &&
          productName is String &&
          productDescription is String &&
          productName != '' &&
          productDescription != '') {
        productManager.addNewProduct(Product(
            productName, productDescription, double.parse(productPrice)));
      }
      print('$productName, $productDescription, $productPrice');
    } catch (e) {
      print('invalid input');
      print('');
    }
  }

  void responseupdate() {
    try {
      List<Product> products = productManager._products;
      productManager.viewAllProducts();
      stdout.writeln(
          'product to be update choose from those above and input the number');
      final index = stdin.readLineSync();
      if (index != null) {
        Product product = products[int.parse(index)];
        stdout.writeln('product updated name if not just pass');
        final productName = stdin.readLineSync();
        if (productName != null && productName != '') {
          product.name = productName;
        }

        stdout.writeln('product description if not just pass');
        final productDescription = stdin.readLineSync();
        if (productDescription != null && productDescription != '') {
          product.description = productDescription;
        }
        stdout.writeln('product price if not just pass');
        final productPrice = stdin.readLineSync();
        if (productPrice != '' && productPrice != null) {
          product.price = double.parse(productPrice);
        }
      }
      productManager.viewAllProducts();
    } catch (e) {
      print(e.toString());
      print('invalid input');
      return;
    }
  }

  void responseViewSingle() {
    try {
      productManager.viewAllProducts();
      stdout.writeln('write product name');
      final productName = stdin.readLineSync();
      if (productName != null && productName != '') {
        productManager.viewSingleProduct(productName);
      }
    } catch (e) {
      print(e.toString());
      print('invalid input');
    }
  }

  void responseViewAll() {
    productManager.viewAllProducts();
  }

  while (true) {
    stdout.writeln("""
    to add product type add
    to view all product type viewall
    to view single product viewone
    to update product update
    to quit type q
    """);
    final input = stdin.readLineSync();
    if (input == 'q') {
      break;
    } else if (input == 'add') {
      responseAdd();
    } else if (input == 'viewall') {
      responseViewAll();
    } else if (input == 'viewone') {
      responseViewSingle();
    } else if (input == 'update') {
      responseupdate();
    }
  }
}

class Product {
  String _name;
  String _description;
  double _price;

  Product(this._name, this._description, this._price);

  String get name => this._name;
  String get description => this._description;
  double get price => this._price;

  void set name(value) {
    _name = value;
  }

  void set description(value) {
    _description = value;
  }

  void set price(value) {
    _price = value;
  }
}

class ProductManager {
  List<Product> _products = [];

  void printProduct(Product product) {
    print('${product.name}, ${product.description}, ${product.price}');
  }

  void addNewProduct(product) {
    this._products.add(product);
  }

  viewAllProducts() {
    int count = 0;
    for (final product in this._products) {
      print(
          '${count}. ${product.name}, ${product.description}, ${product.price}');
      count++;
    }
  }

  viewSingleProduct(String? name) {
    for (final product in this._products) {
      if (product.name == name) {
        this.printProduct(product);
        return product;
      }
    }
    print('product not found');
    return null;
  }

  updateProduct(
      Product product, String? name, String? description, double? price) {
    var newproduct = viewSingleProduct(product.name);

    if (newproduct != null && name != null) {
      newproduct.name = name;
    }

    if (newproduct != null && description != null) {
      newproduct.description = description;
    }

    if (newproduct != null && price != null) {
      newproduct.price = price;
    }

    this.printProduct(newproduct);
    return;
  }
}
