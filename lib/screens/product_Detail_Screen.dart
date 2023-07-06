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
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      //
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(child: Text(loadedProduct.title),color: Colors.black54),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 20,
                ),
                //
                Text(
                  "\$ ${loadedProduct.price}",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                //
                SizedBox(
                  height: 5,
                ),
                //
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    loadedProduct.description,
                    style: Theme.of(context).textTheme.bodySmall,

                  textAlign: TextAlign.center,

                  ),
                ),

                SizedBox(height: 900,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
