import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/helpers.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ItemCard({
    Key? key,
    required this.product,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              product.image.isNotEmpty ? product.image : 'assets/images/placeholder.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Price: ${formatCurrency(product.price)}',
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product.discount > 0
                  ? 'Discount: ${formatCurrency(product.discount)}'
                  : 'No Discount',
              style: TextStyle(
                fontSize: 12,
                color: product.discount > 0 ? Colors.green : Colors.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Stock: ${product.stock}',
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: onAddToCart,
              child: Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
