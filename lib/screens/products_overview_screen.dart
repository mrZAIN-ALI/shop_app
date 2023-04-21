import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

import '../providers/productsModalProvider.dart';
import '../widgets/product_item.dart';
import '../widgets/productGridview.dart';
import '../providers/product_Hub.dart';
import '../widgets/Mybadge.dart';
import 'cart_Screen.dart';

enum FilterOptions {
  Favorites,
  all,
}

class Products_overview_Screen extends StatefulWidget {
  @override
  State<Products_overview_Screen> createState() =>
      _Products_overview_ScreenState();
}

class _Products_overview_ScreenState extends State<Products_overview_Screen> {
  // const Products_overview_Screen({super.key});
  var _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    final productsHub = Provider.of<product_Provider>(context);
    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedOption) {
              setState(() {
                if (selectedOption == FilterOptions.Favorites) {
                  _showFavoriteOnly = true;
                } else if (selectedOption == FilterOptions.all) {
                  _showFavoriteOnly = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favorities"),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text(
                  "Show All",
                ),
                value: FilterOptions.all,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (ctx, cart, ch) => MyBadge(
              child: ch as Widget,
              value: cart.itemCount.toString(),
            ),
            // child: Icon(Icons.shopping_cart),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context,Cart_Screen.routeName);
              },
            ),
          ),
        ],
      ),
      body: ProductGridView(_showFavoriteOnly),
    );
  }
}
