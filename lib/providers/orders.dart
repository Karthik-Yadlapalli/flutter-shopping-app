// ignore_for_file: depend_on_referenced_packages, avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';

class OrderItem {
  final double amount;
  final String id;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.amount,
      required this.id,
      required this.dateTime,
      required this.products});
}

class Orders extends ChangeNotifier {
  final List<OrderItem> _orders = [];
  final Cart cart = Cart();

  List<OrderItem> get orders => _orders;

  void addOrders(List<CartItem> cartProducts, double totla) {
    if (cartProducts.isNotEmpty) {
      orders.insert(
          0,
          OrderItem(
              amount: totla,
              id: DateTime.now().toString(),
              dateTime: DateTime.now(),
              products: cartProducts));
    }
    notifyListeners();
  }
}
