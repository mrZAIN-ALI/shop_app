import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//
import 'cart.dart';

//
class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> items;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.dateTime,
      required this.items});
}

//
class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartItemsList, double total) async {
    final url = Uri.parse(
      "https://demo1-abf1c-default-rtdb.firebaseio.com/orders.json",
    );
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        // "id":timeStamp.toIso8601String(),
        "amount": total,
        "time": timeStamp.toIso8601String(),
        "cartItems": cartItemsList
            .map(
              (cItem) => {
                "id": cItem.id,
                "title": cItem.title,
                "quantity": cItem.quantity,
                "price": cItem.price,
              },
            )
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
          id: json.decode(response.body)["name"],
          amount: total,
          dateTime: timeStamp,
          items: cartItemsList),
    );
    notifyListeners();
  }

  Future<void> fetchAndSetOrder() async {
    final url = Uri.parse(
      "https://demo1-abf1c-default-rtdb.firebaseio.com/orders.json",
    );
    final response = await http.get(url);
    print(
      json.decode(response.body),
    );
  }
}
