import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Order {
  final String id;
  final DateTime date;
  final double totalAmount;
  final double subtotal;
  final double totalDiscount;
  final List<Map<String, dynamic>> items;
  bool isRefunded;

  Order({
    required this.id,
    required this.date,
    required this.totalAmount,
    required this.subtotal,
    required this.totalDiscount,
    required this.items,
    this.isRefunded = false,
  });
}

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder({
    required double totalAmount,
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required double totalDiscount,
  }) {
    final now = DateTime.now();
    final formattedId = DateFormat('yyyyMMddHHmm').format(now);

    _orders.add(Order(
      id: formattedId,
      date: now,
      totalAmount: totalAmount,
      subtotal: subtotal,
      totalDiscount: totalDiscount,
      items: items,
    ));
    notifyListeners();
  }

  void refundOrder(String orderId) {
    final order = _orders.firstWhere((order) => order.id == orderId);
    order.isRefunded = true;
    notifyListeners();
  }
}
