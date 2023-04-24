import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/orderItem.dart' as ord;

class OrderScreen extends StatelessWidget {
  // const OrderScreen({super.key});
    static const routeName="/order";

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      //
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => ord.OrderItem(
          order: orderData.orders[index],
        ),
      ),
    );
  }
}
