import 'package:flutter/material.dart';

class CartItem extends ChangeNotifier {
  String id;
  String title;
  double price;
  int quentity;
  bool isInCart;

  CartItem(
      {required this.id,
      required this.quentity,
      required this.price,
      required this.title,
      required this.isInCart});
}

class Cart extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get item => _items;

  void addItem(String prodId, String title, double price) {
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,
          (existingItem) => CartItem(
              isInCart: existingItem.isInCart = true,
              id: existingItem.id,
              quentity: existingItem.quentity,
              price: existingItem.price,
              title: existingItem.title));
    } else {
      _items.putIfAbsent(
          prodId,
          () => CartItem(
              isInCart: false,
              id: DateTime.now().toString(),
              quentity: 1,
              price: price,
              title: title));
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  String get totalAmt {
    var total = 0.0;

    _items.forEach((key, item) {
      total += item.price * item.quentity;
    });
    return total.toStringAsFixed(2);
  }

  // void removeItem(String productId) {
  //   _items.remove(productId);
  //   notifyListeners();
  // }

  void removeItem(String productId) {
    if (_items.containsKey(productId)) {
      _items.remove(productId);
      notifyListeners();
    }
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quentity > 1) {
      _items.update(
          productId,
          (existing) => CartItem(
              id: existing.id,
              quentity: existing.quentity - 1,
              price: existing.price,
              title: existing.title,
              isInCart: existing.isInCart));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void qIncrement(String prodId) {
    _items.update(
        prodId,
        (value) => CartItem(
            isInCart: value.isInCart,
            id: value.id,
            quentity: value.quentity + 1,
            price: value.price,
            title: value.title));
    notifyListeners();
  }

  // void qDecrement(String prodId) {
  //   _items.update(
  //       prodId,
  //       (value) => CartItem(
  //           id: value.id,
  //           quentity: value.quentity - 1,
  //           price: value.price,
  //           title: value.title));

  //   notifyListeners();
  // }

  void qDecrement(String prodId) {
    if (_items.containsKey(prodId)) {
      final cartItem = _items[prodId]!;
      if (cartItem.quentity > 1) {
        _items.update(
          prodId,
          (value) => CartItem(
              isInCart: value.isInCart,
              id: value.id,
              quentity: value.quentity - 1,
              price: value.price,
              title: value.title),
        );
      } else {
        _items.remove(prodId);
      }
      notifyListeners();
    }
  }

  // void toggleCart(prodId) {
  //   if (_items.containsKey(prodId)) {
  //     final cartItem = _items[prodId]!;
  //     cartItem.isInCart = !cartItem.isInCart;
  //   }
  //   notifyListeners();
  // }

  // bool toggleCart(prdId) {
  //   final carted = _items[prdId]!;
  //   return carted.isInCart;
  // }

  bool toggleCart(String prodId) {
    if (_items.containsKey(prodId)) {
      return _items[prodId]!.isInCart = false;
    }
    return true;
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
