import 'package:flutter/material.dart';

class Product_item extends StatelessWidget {
  // const Product_item({super.key});
  final String id;
  final String title;
  final String img_Url;

  Product_item(
    {required this.id,
    required this.title,
    required this.img_Url}
  );

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(img_Url , fit: BoxFit.cover,),
       footer:  GridTileBar(
        backgroundColor: Colors.black54,

        leading: Icon(Icons.favorite),
        title: Text(title), 
        trailing: Icon(Icons.shopping_cart),

      ),
    );
  }
}