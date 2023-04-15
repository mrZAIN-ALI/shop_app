import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/products.dart';
import '../widgets/product_item.dart';
import '../widgets/productGridview.dart';
class Products_overview_Screen extends StatelessWidget {
  // const Products_overview_Screen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: ProductGridView(),
    );
  }
}

