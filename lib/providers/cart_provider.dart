import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../providers/order_provider.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems => _cartItems;

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      updateQuantity(product.id, _cartItems[product.id]!.quantity + 1);
    } else {
      _cartItems[product.id] = CartItem(
        productId: product.id,
        name: product.name,
        price: product.price,
        quantity: 1,
        discount: product.discount,
      );
    }
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) {
    if (_cartItems.containsKey(productId)) {
      _cartItems[productId]!.quantity = quantity;
      if (quantity <= 0) {
        removeFromCart(productId);
      }
      notifyListeners();
    }
  }

  void removeFromCart(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  double get subtotal =>
      _cartItems.values.fold(0, (total, item) => total + item.price * item.quantity);

  double get totalDiscount =>
      _cartItems.values.fold(0, (total, item) => total + item.discount * item.quantity);

  double get netTotal => subtotal - totalDiscount;

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  String checkout(OrderProvider orderProvider, List<Product> availableProducts) {
    for (var cartItem in _cartItems.values) {
      final product = availableProducts.firstWhere(
              (prod) => prod.id == cartItem.productId,
          orElse: () => Product(
              id: '',
              name: '',
              price: 0,
              stock: 0,
              image: '',
              description: ''));

      if (cartItem.quantity > product.stock) {
        return 'Stock unavailable for ${cartItem.name}!';
      }
    }

    for (var cartItem in _cartItems.values) {
      final product = availableProducts.firstWhere((prod) => prod.id == cartItem.productId);
      product.stock -= cartItem.quantity;
    }
    final List<Map<String, dynamic>> orderedItems = _cartItems.values
        .map((item) => {
      'name': item.name,
      'price': item.price,
      'quantity': item.quantity,
      'totalPrice': item.totalPrice,
    })
        .toList();
    orderProvider.addOrder(
      totalAmount: netTotal,
      items: orderedItems,
      subtotal: subtotal,
      totalDiscount: totalDiscount,
    );
    clearCart();
    return 'Success';
  }
}
