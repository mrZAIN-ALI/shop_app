import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  OrderItem({required this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    // Provider.of<Orders>(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? min(widget.order.items.length * 20.0 + 50, 180) : 100,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "\$ " + widget.order.amount.toString(),
                ),
                subtitle: Text(
                  DateFormat('dd/MM/yy hh:mm').format(
                    widget.order.dateTime,
                  ),
                ),
                trailing: FloatingActionButton.extended(
                  heroTag:widget.order.amount.toString()+widget.order.dateTime.toString() ,
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  label: Text("show"),
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                ),
              ),
              Divider(),
              //
              
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.all(10),
                  height: _expanded ? min(widget.order.items.length * 20.0 + 50, 180) : 100 ,
                  //
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 5),
                      children: widget.order.items
                          .map(
                            (e) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e.title,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  e.quantity.toString() +
                                      "X   \$" +
                                      e.price.toString(),
                                ),
                              ],
                            ),
                          )
                          .toList() as List<Widget>),
                ),
                
            ],
          ),
        ),
      ),
    );
  }
}
