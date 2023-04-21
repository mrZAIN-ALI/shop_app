import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class Cart_Screen extends StatelessWidget {
  // const Cart_Screen({super.key});
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Chip(                    
                    label: Text(
                      "\$ "+cart.totalAmount.toString(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
