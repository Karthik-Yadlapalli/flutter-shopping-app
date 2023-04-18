import 'dart:math';

import 'package:flutter/material.dart';
import '../providers/orders.dart';
import 'package:intl/intl.dart';

class OrderItems extends StatefulWidget {
  const OrderItems({super.key, required this.items});
  final OrderItem items;

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text("\$${widget.items.amount}"),
              subtitle: Text(
                  DateFormat("dd/mm/yyyy hh:mm").format(widget.items.dateTime)),
              trailing: IconButton(
                icon: (_expanded)
                    ? const Icon(Icons.expand_less)
                    : const Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            if (_expanded)
              SizedBox(
                height: min(widget.items.products.length * 20.0 + 80, 180),
                child: ListView(
                  children: widget.items.products
                      .map((prod) => Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(prod.title),
                                Text("${prod.quentity}  X  \$${prod.price}")
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ElevatedButton(onPressed: () {}, child: const Text('Payment'))
          ],
        ),
      ),
    );
  }
}
