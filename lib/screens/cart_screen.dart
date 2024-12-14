import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../repositories/product_repository.dart';
import '../utils/helpers.dart';
import '../widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  final ProductRepository productRepository = ProductRepository();

  void _showMessageDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Checkout'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: cartProvider.cartItems.isEmpty
                ? null
                : () => cartProvider.clearCart(),
          ),
        ],
      ),
      body: cartProvider.cartItems.isEmpty
          ? Center(
        child: Text(
          'Your cart is empty',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartProvider.cartItems.values.toList()[index];
                return CartItemCard(
                  cartItem: cartItem,
                  onIncrease: () => cartProvider.updateQuantity(
                      cartItem.productId, cartItem.quantity + 1),
                  onDecrease: () => cartProvider.updateQuantity(
                      cartItem.productId, cartItem.quantity - 1),
                  onRemove: () => cartProvider.removeFromCart(cartItem.productId),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subtotal: ${formatCurrency(cartProvider.subtotal)}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Discount: ${formatCurrency(cartProvider.totalDiscount)}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Net Total: ${formatCurrency(cartProvider.netTotal)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final availableProducts = await productRepository.fetchProducts();
                    final result = cartProvider.checkout(orderProvider, availableProducts);

                    _showMessageDialog(context, result);
                  },
                  child: Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
