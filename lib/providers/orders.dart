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
  final _authToken;
  List<OrderItem> _orders = [];
  final _userId;

  Orders(
    this._authToken,
    this._orders,
    this._userId,
  );
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartItemsList, double total) async {
    final url = Uri.parse(
      "https://demo1-abf1c-default-rtdb.firebaseio.com/orders/$_userId.json?auth=$_authToken",
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

  Future fetchAndSetOrder() async {
   
    try {
       final urL = Uri.parse(
      "https://demo1-abf1c-default-rtdb.firebaseio.com/orders/$_userId.json?auth=$_authToken",
    );
      final http.Response response = await http.get(urL);

      // print(
      //   "Printing get  " + json.decode(response.body),
      // );

      List<OrderItem> dummyList = [];
      if (response.body == null || response.body == "null") {
        return;
      }
      final orderedProd = json.decode(response.body) as Map<String, dynamic>;
      if (orderedProd == null) {
        print("lol");
        return;
      }
      orderedProd.forEach(
        (key, value) {
          dummyList.add(
            OrderItem(
              id: key,
              amount: value["amount"],
              dateTime: DateTime.parse(value["time"]),
              items: (value["cartItems"] as List<dynamic>)
                  .map(
                    (item) => CartItem(
                      id: item["id"],
                      title: item["title"],
                      quantity: item["quantity"],
                      price: item["price"],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );
      _orders = dummyList.reversed.toList();
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }
}
