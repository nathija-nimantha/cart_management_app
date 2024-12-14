import 'package:flutter/material.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';
import '../providers/cart_provider.dart';
import '../widgets/item_card.dart';
import 'package:provider/provider.dart';

class ItemScreen extends StatelessWidget {
  final ProductRepository productRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: productRepository.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching products'));
        } else if (snapshot.hasData) {
          final products = snapshot.data!;
          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 3 / 4,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ItemCard(
                product: product,
                onAddToCart: () {
                  Provider.of<CartProvider>(context, listen: false)
                      .addToCart(product);
                },
              );
            },
          );
        }
        return Center(child: Text('No products available'));
      },
    );
  }
}
