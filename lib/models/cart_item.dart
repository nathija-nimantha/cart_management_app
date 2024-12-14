class CartItem {
  final String productId;
  final String name;
  final double price;
  int quantity;
  final double discount;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.discount = 0.0,
  });

  double get totalPrice => (price - discount) * quantity;
}
