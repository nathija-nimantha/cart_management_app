import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/cart_item.dart';

class StorageService {
  Future<void> saveCartToStorage(Map<String, CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = cartItems.map((key, item) => MapEntry(
      key,
      json.encode({
        'productId': item.productId,
        'name': item.name,
        'price': item.price,
        'quantity': item.quantity,
      }),
    ));
    await prefs.setString('cart', json.encode(cartData));
  }

  Future<Map<String, CartItem>> loadCartFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    if (cartData == null) return {};

    final Map<String, dynamic> decodedCart = json.decode(cartData);
    return decodedCart.map((key, item) {
      final decodedItem = json.decode(item);
      return MapEntry(
        key,
        CartItem(
          productId: decodedItem['productId'],
          name: decodedItem['name'],
          price: decodedItem['price'],
          quantity: decodedItem['quantity'],
        ),
      );
    });
  }

  Future<void> clearStoredCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
  }
}
