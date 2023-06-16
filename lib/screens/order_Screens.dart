import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/orderItem.dart' as ord;
import '../widgets/app_drawer.dart';

class OrderScreen extends StatefulWidget {
  // const OrderScreen({super.key});
  static const routeName = "/order";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future _odersFuture;

  Future obtianFuture(){
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrder();
  }
  @override
  void initState() {
    // TODO: implement initState
    _odersFuture=obtianFuture();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: FutureBuilder(
        future: _odersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              // Handle the error
              return Center(child: Text("Aww Snap Error occurred!"));
            } else {
              return Consumer<Orders>(
                builder: (context, orderData, child) {
                  return ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (context, index) => ord.OrderItem(
                      
                      order: orderData.orders[index],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
      drawer: const  AppDrawer(),
    );
  }
}
