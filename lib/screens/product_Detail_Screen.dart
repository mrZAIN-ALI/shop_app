import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_Hub.dart';
import '../providers/productsModalProvider.dart';

class ProductDetailsScreen extends StatelessWidget {
  // const ProductDetailsScreen({super.key});
  static const routeName = "product-Detail";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;     
    final loadedProduct=Provider.of<product_Provider>(context,listen: false).findByid(id);

    
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
    );
  }
}
