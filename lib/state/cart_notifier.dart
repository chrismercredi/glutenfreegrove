import 'package:flutter/material.dart';

import '../models/models.dart';

class CartNotifier extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(Item item) {
    // Check if item already exists in the cart
    for (var cartItem in _items) {
      if (cartItem.item.id == item.id) {
        // If item exists, just update the quantity
        cartItem.quantity++;
        notifyListeners();
        return;
      }
    }

    // If item does not exist in the cart, add a new entry
    _items.add(CartItem(item: item));
    notifyListeners();
  }

  void removeItem(int itemId) {
    _items.removeWhere((cartItem) => cartItem.item.id == itemId);
    notifyListeners();
  }

  void updateQuantity(int itemId, int quantity) {
    for (var cartItem in _items) {
      if (cartItem.item.id == itemId) {
        cartItem.quantity = quantity;
        notifyListeners();
        return;
      }
    }
  }

  double get totalCost {
    return _items.fold(0.0, (total, current) => total + current.totalPrice);
  }
}
