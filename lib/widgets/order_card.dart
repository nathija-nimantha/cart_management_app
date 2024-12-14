import 'package:flutter/material.dart';
import '../providers/order_provider.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onRefund;

  const OrderCard({
    Key? key,
    required this.order,
    this.onRefund,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Order ID: ${order.id}'),
        subtitle: Text(
            'Date: ${order.date.toLocal()} - Total: \$${order.totalAmount.toStringAsFixed(2)}'),
        trailing: order.isRefunded
            ? Text('Refunded', style: TextStyle(color: Colors.green))
            : TextButton(
          onPressed: onRefund,
          child: Text('Refund'),
        ),
      ),
    );
  }
}
