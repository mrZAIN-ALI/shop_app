import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_Hub.dart';
import '../providers/productsModalProvider.dart';
import './product_item.dart';

class ProductGridView extends StatelessWidget {
  final showFav;
  ProductGridView(this.showFav);

  @override
  Widget build(BuildContext context) {
    final productData = context.watch<product_Provider>();
    final loaded_Products = showFav ? productData.getFavProducts() : productData.getProductList();

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loaded_Products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        // create: (context) => loaded_Products[index],
        value: loaded_Products[index],
        child: Product_item(),
      ),
    );
  }
}
