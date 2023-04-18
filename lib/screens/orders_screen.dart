// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Orders"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: ((context, index) =>
              OrderItems(items: orderData.orders[index])),
        ));
  }
}
