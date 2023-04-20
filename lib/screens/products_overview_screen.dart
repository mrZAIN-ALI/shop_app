import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../providers/productsModalProvider.dart';
import '../widgets/product_item.dart';
import '../widgets/productGridview.dart';
import '../providers/product_Hub.dart';

enum FilterOptions {
  Favorites,
  all,
}

class Products_overview_Screen extends StatelessWidget {
  // const Products_overview_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsHub = Provider.of<product_Provider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedOption) {
              if (selectedOption == FilterOptions.Favorites) {
                print(selectedOption);
                productsHub.showFavritesOnlu();
              } else if (selectedOption == FilterOptions.all) {
                print(selectedOption);
                productsHub.showAll();
              }
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
          )
        ],
      ),
      body: ProductGridView(),
    );
  }
}
