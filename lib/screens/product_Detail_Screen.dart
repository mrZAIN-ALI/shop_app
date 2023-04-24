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
    final loadedProduct =
        Provider.of<product_Provider>(context, listen: false).findByid(id);

    //
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      //
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            //
            SizedBox(
              height: 20,
            ),
            //
            Text(
              "\$ ${loadedProduct.price}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            //
            SizedBox(
              height: 5,
            ),
            //
            Container(
              padding: EdgeInsets.all(10),
              child: Text(loadedProduct.description,
              style: Theme.of(context).textTheme.bodySmall,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
