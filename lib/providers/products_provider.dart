// ignore_for_file: prefer_final_fields, unused_field, list_remove_unrelated_type, prefer_const_constructors, avoid_print, use_rethrow_when_possible, unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'products.dart';
import 'package:http/http.dart' as http;

class Products extends ChangeNotifier {
  List<Product> _items = [];

  // var _favoritesOnly = false;

  List<Product> get item {
    return [..._items];
  }

  List<Product> get favouritItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  Product findById(String id) {
    return item.firstWhere((element) => element.id == id);
  }

  ///Fetching Products from DB///
  Future<void> fetchAndSetProducts() async {
    final url = Uri.https(
      'flutter-shop-3f87c-default-rtdb.firebaseio.com',
      '/products.json',
    );

    try {
      final response = await http.get(url);
      final extractedProducts =
          json.decode(response.body) as Map<String, dynamic>;
      if (extractedProducts == null) {
        return;
      }
      final List<Product> loadedProduct = [];
      extractedProducts.forEach((prodId, prodData) {
        loadedProduct.add(Product(
            dimensions: prodData['dimensions'],
            shipping_return_details: prodData['shipping'],
            material: prodData['material'],
            careInstruction: prodData['care'],
            id: prodId,
            description: prodData['descreption'],
            title: prodData['title'],
            imageUrl: prodData['imgUrl'],
            price: prodData['price']));
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ///Adding Products to DB///
  Future<void> addProduct(Product product) async {
    final url = Uri.https(
      'flutter-shop-3f87c-default-rtdb.firebaseio.com',
      '/products.json',
    );

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'descreption': product.description,
          'price': product.price,
          'shipping': product.shipping_return_details,
          'material': product.material,
          'dimensions': product.dimensions,
          'imgUrl': product.imageUrl,
          'care': product.careInstruction,
          'isFav': product.isFavourite
        }),
      );

      var newProduct = Product(
          dimensions: product.dimensions,
          shipping_return_details: product.shipping_return_details,
          material: product.material,
          careInstruction: product.careInstruction,
          id: json.decode(response.body)['name'],
          description: product.description,
          title: product.title,
          imageUrl: product.imageUrl,
          price: product.price);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ///Deleting Products from DB///
  Future<void> deleteProduct(String id) async {
    final url = Uri.https(
      'flutter-shop-3f87c-default-rtdb.firebaseio.com',
      '/products/$id.json',
    );
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException("Can't delete the product.");
    }
    existingProduct = null;
  }

  ///Updating Products in DB///
  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url = Uri.https(
        'flutter-shop-3f87c-default-rtdb.firebaseio.com',
        '/products/$id.json',
      );
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'descreption': newProduct.description,
            'dimensions': newProduct.dimensions,
            'shipping': newProduct.shipping_return_details,
            'care': newProduct.careInstruction,
            'material': newProduct.material,
            'imgUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
