import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemCard({
    Key? key,
    required this.cartItem,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(cartItem.name[0]),
        ),
        title: Text(cartItem.name),
        subtitle: Text(
          'Price: ${cartItem.price.toStringAsFixed(2)} | Total: ${cartItem.totalPrice.toStringAsFixed(2)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onDecrease,
              icon: Icon(Icons.remove),
            ),
            Text(cartItem.quantity.toString()),
            IconButton(
              onPressed: onIncrease,
              icon: Icon(Icons.add),
            ),
            IconButton(
              onPressed: onRemove,
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
