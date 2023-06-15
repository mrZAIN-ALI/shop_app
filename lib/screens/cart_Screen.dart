import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart' as ca;
import '../providers/orders.dart';

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
                  orderButton(cart: cart),
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
                mapKey: cart.items_map.keys.toList()[i],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class orderButton extends StatefulWidget {
  const orderButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<orderButton> createState() => _orderButtonState();
}

class _orderButtonState extends State<orderButton> {
  var _isLoading= false;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: (widget.cart.totalAmount<=0 || _isLoading)? null : () async {
        setState(() {
          _isLoading=true;
        });
        await Provider.of<Orders>(context, listen: false).addOrder(
            widget.cart.items_map.values.toList(), widget.cart.totalAmount,);
            setState(() {
              _isLoading=false;
            });

        widget.cart.clear();
      },
      label: _isLoading? CircularProgressIndicator(): Text("Payment"),
      icon: Icon(Icons.paypal_outlined),
      splashColor: Theme.of(context).colorScheme.onSecondary,
    );
  }
}
