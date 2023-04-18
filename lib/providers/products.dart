// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

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

  void toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
