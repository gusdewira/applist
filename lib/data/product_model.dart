class Product {
  int? id;
  String? name;
  int? price;
  int? stock;
  String? description;

  Product({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.description,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    stock = json['stock'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
      'description': description,
    };
  }
}