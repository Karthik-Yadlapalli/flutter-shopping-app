// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Cart>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart Items'),
        ),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Total",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Chip(
                      label: Text('\$ ${cartItem.totalAmt}'),
                      backgroundColor: const Color.fromARGB(255, 115, 153, 71),
                    ),
                    OrderButton(cartItem: cartItem)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
                child: cartItem.item.isEmpty
                    ? const Center(
                        child: Text(
                        'your cart is Empty!!',
                        style: TextStyle(fontSize: 20),
                      ))
                    : ListView.builder(
                        itemCount: cartItem.itemCount,
                        itemBuilder: (context, index) {
                          return ci.CartItem(
                              productId: cartItem.item.keys.toList()[index],
                              id: cartItem.item.values.toList()[index].id,
                              quentity:
                                  cartItem.item.values.toList()[index].quentity,
                              price: cartItem.item.values.toList()[index].price,
                              title:
                                  cartItem.item.values.toList()[index].title);
                        }))
          ],
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    super.key,
    required this.cartItem,
  });
  final Cart cartItem;
  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (double.parse(widget.cartItem.totalAmt) <= 0 || _isLoading)
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrders(
                    widget.cartItem.item.values.toList(),
                    double.parse(widget.cartItem.totalAmt));
                setState(() {
                  _isLoading = false;
                });
                widget.cartItem.clear();
              },
        child: _isLoading
            ? const CircularProgressIndicator()
            : const Text(
                'Place Order',
                style: TextStyle(fontWeight: FontWeight.bold),
              ));
  }
}
