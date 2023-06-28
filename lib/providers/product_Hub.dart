import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'productsModalProvider.dart';
import '../modals/httpDeleteProdException.dart';

class product_Provider with ChangeNotifier {
  final String _authToken;

  @override
  product_Provider.scndry(this._authToken,this._productsList);
  // product_Provider(): _authToken="Z";

  // product_Provider();
  //
  List<Product> _productsList = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // bool isFavoritesRequested = false;

  // void showFavritesOnlu() {
  //   isFavoritesRequested = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   isFavoritesRequested = false;
  //   notifyListeners();
  // }

  List<Product> getFavProducts() {
    return _productsList.where((element) => element.isFavorite).toList();
  }

  List<Product> getProductList() {
    // if (isFavoritesRequested) {
    //   return _productsList.where((element) => element.isFavorite).toList();
    // }
    return [..._productsList];
  }

  Future<void> fetchProducts() async {
    // print("This is Auth toke:"+_authToken);
    final url = Uri.parse(
      "https://demo1-abf1c-default-rtdb.firebaseio.com/products.json?auth=$_authToken",
    );
    try {
      final response = await http.get(url);
      final List<Product> _prodList = [];
      final _fetchedProduts =
          json.decode(response.body) as Map<String, dynamic>;
      if(_fetchedProduts==null){
        return;
      }
      _fetchedProduts.forEach((key, value) {
        _prodList.add(
          Product(
            id: key,
            title: value["title"],
            description: value["description"],
            imageUrl: value["imageUrl"],
            price: value["price"],
            isFavorite:  value["isFvrt"] == "true" ? true : false,
          ),
        );
      });
      _productsList = _prodList;
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> addProductToLost(Product newProduct) async {
    final url = Uri.parse(
      "https://demo1-abf1c-default-rtdb.firebaseio.com/products.json",
    );
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "title": newProduct.title,
            "description": newProduct.description,
            "price": newProduct.price,
            "imageUrl": newProduct.imageUrl,
            "isFvrt": newProduct.isFavorite,
          },
        ),
      );

      final addThisProdcut = Product(
        description: newProduct.description,
        imageUrl: newProduct.imageUrl,
        price: newProduct.price,
        title: newProduct.title,
        id: json.decode(response.body)["name"],
      );
      _productsList.add(addThisProdcut);
      notifyListeners();
      // hell'
      print(
        json.decode(response.body),
      );
      if (response.statusCode == 200) {
        // Request successful
        print("Product added successfully!");
      } else {
        // Request failed
        print("Failed to add product. Error: ${response.statusCode}");
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Product findByid(String id) {
    return _productsList.firstWhere((prod) => prod.id == id);
  }

  Future<void> updateProduct(String id, Product updatedProd) async {
    final url = Uri.parse(
      "https://demo1-abf1c-default-rtdb.firebaseio.com/products/$id.json",
    );
    final indexOfProductToUPdate =
        _productsList.indexWhere((element) => element.id == id);
    if (indexOfProductToUPdate >= 0) {
      await http.patch(
        url,
        body: json.encode(
          {
            "title": updatedProd.title,
            "description": updatedProd.description,
            "price": updatedProd.price,
            "imageUrl": updatedProd.imageUrl,
          },
        ),
      );
      _productsList[indexOfProductToUPdate] = updatedProd;
      notifyListeners();
    } else {
      print("Invalid index for product list for update request");
    }
  }

  Future<void> deleteProductById(String id) async {
    final url = Uri.parse(
      "https://demo1-abf1c-default-rtdb.firebaseio.com/products/$id.json",
    );
    final indexOfProduct =
        _productsList.indexWhere((element) => element.id == id);
    Product lastCopyy = _productsList[indexOfProduct];

    _productsList.removeWhere((element) => element.id == id);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _productsList.insert(indexOfProduct, lastCopyy);
      notifyListeners();
      throw HttpException("Cannot delete product on server");
    }
    lastCopyy =
        Product(id: "", title: "", description: "", price: 0, imageUrl: "");
  }
}
