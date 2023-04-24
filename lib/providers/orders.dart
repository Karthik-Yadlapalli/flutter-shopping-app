// ignore_for_file: depend_on_referenced_packages, avoid_web_libraries_in_flutter, unnecessary_null_comparison
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;

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
  List<OrderItem> _orders = [];
  final Cart cart = Cart();

  List<OrderItem> get orders => _orders;

//Adding Orders to DB
  Future<void> addOrders(List<CartItem> cartProducts, double totla) async {
    final url = Uri.https(
      'flutter-shop-3f87c-default-rtdb.firebaseio.com',
      '/orders.json',
    );
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': totla,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((element) => {
                    'id': element.id,
                    'quentity': element.quentity,
                    'price': element.price,
                    'title': element.title,
                    'iscarted': element.isInCart
                  })
              .toList()
        }));

    if (cartProducts.isNotEmpty) {
      orders.insert(
          0,
          OrderItem(
              amount: totla,
              id: json.decode(response.body)['name'],
              dateTime: timeStamp,
              products: cartProducts));
    }
    notifyListeners();
  }

  //Fitching the Orders from DB
  Future<void> fetchAndSetOrders() async {
    final url = Uri.https(
      'flutter-shop-3f87c-default-rtdb.firebaseio.com',
      '/orders.json',
    );
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }

    final List<OrderItem> loadedOrders = [];
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          amount: orderData['amount'],
          id: orderId,
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((element) => CartItem(
                  id: element['id'],
                  quentity: element['quentity'],
                  price: element['price'],
                  title: element['title'],
                  isInCart: element['iscarted']))
              .toList()));
    });
    _orders = loadedOrders;
    notifyListeners();
  }
}
