import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_Hub.dart';
import '../widgets/user_product_Item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {

  static const routeName="/user-products"; 
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<product_Provider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productData.getProductList().length,
          itemBuilder: (_, index) {
            return UseerProductItem(
              title: productData.getProductList()[index].title,
              imgUrl: productData.getProductList()[index].imageUrl,
            );
          },
        ),
      ),
    );
  }
}
