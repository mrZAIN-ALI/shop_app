import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/productsModalProvider.dart';

import '../screens/product_Detail_Screen.dart';

class Product_item extends StatelessWidget {
  // const Product_item({super.key});
  // final String id;
  // final String title;
  // final String img_Url;

  // Product_item({required this.id, required this.title, required this.img_Url});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.togglefvtStatus();
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            product.title,
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
