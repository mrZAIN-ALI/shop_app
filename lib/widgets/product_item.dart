import 'package:flutter/material.dart';

import '../screens/product_Detail_Screen.dart';

class Product_item extends StatelessWidget {
  // const Product_item({super.key});
  final String id;
  final String title;
  final String img_Url;

  Product_item({required this.id, required this.title, required this.img_Url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,arguments: title);
          },
          child: Image.network(
            img_Url,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
            ),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
