// ignore_for_file: depend_on_referenced_packages, unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  static const routeName = '/orders';
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) async {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Your Orders"),
            centerTitle: true,
          ),
          body: _bodyWidget()),
    );
  }

  Widget _bodyWidget() {
    Widget body;
    final orderData = Provider.of<Orders>(context, listen: false);
    if (_isLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (orderData.orders.isEmpty) {
      body = const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'You haven\'t orderd yet, \nstart your journey with us by making your first order and claim a chance to exicting prizes',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    } else {
      body = ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: ((context, index) =>
            OrderItems(items: orderData.orders[index])),
      );
    }
    return body;
  }
}
