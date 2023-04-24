import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;
  OrderItem({required this.order});

  @override
  Widget build(BuildContext context) {
    // Provider.of<Orders>(context);
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "\$ " + order.amount.toString(),
              ),
              subtitle: Text(
                DateFormat('dd MM yy hh:mm').format(
                  order.dateTime,
                ),
              ),
              trailing: FloatingActionButton.extended(
                onPressed: () {
                  null;
                },
                label: Text("show"),
                icon: Icon(Icons.expand_more),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
