import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items_map {
    return {..._items};
  }
  //We are Using product id as key in 
  void add_item(String p_id, String p_title, double p_price) {
    if (_items.containsKey(p_id)) {
      _items.update(
        p_id,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity + 1,
            price: existingCartItem.price),
      );
    } else {
      _items.putIfAbsent(
        p_id,
        () => CartItem(id: p_id, title: p_title, quantity: 1, price: p_price),
      );
    }
  }
}
