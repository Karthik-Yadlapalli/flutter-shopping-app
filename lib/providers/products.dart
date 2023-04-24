// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product extends ChangeNotifier {
  String id;
  String title;
  String description;
  String careInstruction;
  String material;
  String dimensions;
  String shipping_return_details;
  String imageUrl;
  double price;
  bool isFavourite;

  Product({
    required this.dimensions,
    required this.shipping_return_details,
    required this.material,
    required this.careInstruction,
    required this.id,
    required this.description,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.isFavourite = false,
  });

  void _setFav(bool newValue) {
    isFavourite = newValue;
  }

  Future<void> toggleFavourite() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = Uri.https(
      'flutter-shop-3f87c-default-rtdb.firebaseio.com',
      '/products/$id.json',
    );
    try {
      final response =
          await http.patch(url, body: json.encode({'isFav': isFavourite}));
      if (response.statusCode >= 400) {
        _setFav(oldStatus);
      }
    } catch (e) {
      _setFav(oldStatus);
    }
  }
}
