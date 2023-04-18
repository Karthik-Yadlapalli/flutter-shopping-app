// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {super.key,
      required this.id,
      required this.productId,
      required this.title,
      required this.price,
      required this.quentity});
  final String title;
  final double price;
  final int quentity;
  final String id;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: const Color.fromARGB(255, 204, 202, 202),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$$price')),
          ),
          title: Text(title),
          trailing: Container(
              width: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Provider.of<Cart>(context, listen: false)
                            .qIncrement(productId);
                      },
                      child: Icon(
                        Icons.add,
                        size: 15,
                      )),
                  Text('$quentity X'),
                  GestureDetector(
                      onTap: () {
                        Provider.of<Cart>(context, listen: false)
                            .qDecrement(productId);
                      },
                      child: Icon(
                        Icons.remove,
                        size: 15,
                      ))
                ],
              )),
        ),
      ),
    );
  }
}
