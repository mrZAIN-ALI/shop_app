import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'package:provider/provider.dart';
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  var isFavorite;
  final String authToken;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite,
     this.authToken="default",
  });

  void _setOldFavStatus(bool val){
    isFavorite=val;
    notifyListeners();
  }
  Future<void> togglefvtStatus(String userId) async {
    final url = Uri.parse(
      "https://demo1-abf1c-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken",
    );
    final oldStatus=isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response=await http.put(
        url,
        body: json.encode(
           isFavorite,
        ),
      );
      if(response.statusCode>=400){
        _setOldFavStatus(oldStatus);

      }
    } catch (err) {
        _setOldFavStatus(oldStatus);
    }
  }
}
