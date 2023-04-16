import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  // const ProductDetailsScreen({super.key});
  static const routeName = "product-Detail";

  @override
  Widget build(BuildContext context) {
    
    final title = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
