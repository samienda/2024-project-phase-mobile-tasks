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



class ProductManager{
  List<Product> _products = [];

  void addNewProduct(product ){
    this._products.add(product);
  }

  List<Product> get viewAllProducts => this._products;

  Product? viewSingleProduct(String? name, String? description){
    for (final product in this._products){
      if (product.name == name || product.description == description ){
        return product;
      }
    }
    return null;
  }


  Product? updateProduct(Product product, String? name, String? description, bool? price){
    var newproduct = viewSingleProduct(product.name, product.description);


    if (newproduct != null && name != null){
      newproduct.name = name;
    }

    if (newproduct != null && description != null){
      newproduct.description = description;
    }

    if (newproduct != null && price != null){
      newproduct.price = price;
    }

    print(this._products);
    return newproduct;
    
  }
}



void main() {
  // // Create three products
  // Product product1 = Product("Product 1","Description 1",10.0);
  // Product product2 = Product("Product 2",  "Description 2", 20.0);
  // Product product3 = Product("Product 3",  "Description 3", 30.0);

  // ProductManager productManager = ProductManager();
  // productManager.addNewProduct(product1);
  // productManager.addNewProduct(product2);
  // productManager.addNewProduct(product3);

  // print(productManager.viewAllProducts);
}