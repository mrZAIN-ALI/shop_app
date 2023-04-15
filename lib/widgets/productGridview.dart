import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../models/products.dart';
import './product_item.dart';

class ProductGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = context.watch<product_Provider>();
    final loaded_Products = productData.productsList;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loaded_Products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15),
      itemBuilder: (context, index) => Product_item(
          id: loaded_Products[index].id,
          title: loaded_Products[index].title,
          img_Url: loaded_Products[index].imageUrl),
    );
  }
}
