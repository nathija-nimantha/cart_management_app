class Product {
  final String id;
  final String name;
  final double price;
  int stock;
  final String image;
  final String description;
  final double discount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.image,
    required this.description,
    this.discount = 0.0,
  });
}
