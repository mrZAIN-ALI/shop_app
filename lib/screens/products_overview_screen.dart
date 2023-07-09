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
import '../widgets/app_drawer.dart';
import '../providers/product_Hub.dart';

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
  // @override
  // void initState() {
  //   // Provider.of<product_Provider>(context).fetchProducts();
  //   Future.delayed(Duration.zero).then((_) {
  //     Provider.of<product_Provider>(context).fetchProducts();
  //   },);
  //   // TODO: implement initState
  //   super.initState();
  // }

  var _showFavoriteOnly = false;
  var _isInitialized = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInitialized) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<product_Provider>(context,).fetchProducts().then(
        (_) {
          setState(() {
            _isLoading = false;
          });
        },
      );
    }
    _isInitialized = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsHub = Provider.of<product_Provider>(context);
    final cart = Provider.of<Cart>(context, listen: false);

    return ScaffoldMessenger(
      child: Scaffold(
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
                  Navigator.pushNamed(context, Cart_Screen.routeName);
                },
              ),
            ),
          ],
        ),
        //
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductGridView(
                _showFavoriteOnly,
              ),
        //
        drawer: AppDrawer(),
      ),
    );
  }
}
