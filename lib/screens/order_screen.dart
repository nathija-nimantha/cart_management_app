import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../utils/helpers.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: orderProvider.orders.isEmpty
          ? Center(child: Text('No orders placed'))
          : ListView.builder(
        itemCount: orderProvider.orders.length,
        itemBuilder: (context, index) {
          final order = orderProvider.orders[index];
          return OrderCard(order: order);
        },
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text('Order ID: ${widget.order.id}'),
            subtitle: Text('Total: ${formatCurrency(widget.order.totalAmount)}'),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: widget.order.items.map((item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item['name']} (x${item['quantity']})'),
                      Text('${formatCurrency(item['totalPrice'])}'),
                    ],
                  );
                }).toList(),
              ),
            ),
          if (_isExpanded)
            ElevatedButton(
              onPressed: widget.order.isRefunded
                  ? null
                  : () {
                orderProvider.refundOrder(widget.order.id);
              },
              child: Text(widget.order.isRefunded ? 'Refunded' : 'Refund'),
            ),
        ],
      ),
    );
  }
}
