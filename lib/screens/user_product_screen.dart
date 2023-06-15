import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

import '../providers/product_Hub.dart';
import '../widgets/user_product_Item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "/user-products";
    
  Future<void> refreshPage(BuildContext ctx) async{
    await Provider.of<product_Provider>(ctx,listen: false).fetchProducts();
  }
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<product_Provider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Your Products"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditPrudcutScreen.routeName);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () => refreshPage(context),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: productData.getProductList().length.toInt(),
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    UseerProductItem(
                      title: productData.getProductList()[index].title,
                      imgUrl: productData.getProductList()[index].imageUrl,
                      id: productData.getProductList()[index].id,
                      
                    ),
                    Divider(),
                  ], 
                );
              },
            ),
          ),
        ),
      );
    
  }
}
