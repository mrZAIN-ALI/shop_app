import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart' as ca;

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
                      "\$ " + cart.totalAmount.toString(),
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton.extended(
                    onPressed: () {
                      print("object");
                    },
                    label: Text("Payment"),
                    icon: Icon(Icons.paypal_outlined),
                    splashColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items_map.length,
              itemBuilder: (context, i) => ca.Cart_Item(
                id: cart.items_map.values.toList()[i].id,
                price: cart.items_map.values.toList()[i].price,
                title: cart.items_map.values.toList()[i].title,
                quantity: cart.items_map.values.toList()[i].quantity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
