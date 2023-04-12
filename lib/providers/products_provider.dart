import 'package:flutter/widgets.dart';
import '../models/products.dart';

class product_Provider with ChangeNotifier {
  List<Product> _productsList = [];

  List<Product> getProductList() {
    return [..._productsList];
  }

  void addProductToLost(Product item) {
    _productsList.add(item);
    notifyListeners();
  }
}
