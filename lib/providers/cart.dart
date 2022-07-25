import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int qty;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.qty,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId].qty > 1)
      _items.update(
          productId,
          (value) => CartItem(
                id: value.id,
                title: value.title,
                qty: value.qty - 1,
                price: value.price,
              ));
    else
      _items.remove(productId);
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  double get totalAmount {
    double sum = 0.0;
    _items.forEach((key, value) {
      sum += value.price * value.qty;
    });
    return sum;
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              qty: value.qty + 1,
              price: value.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                qty: 1,
                price: price,
              ));
    }
    notifyListeners();
  }
}
