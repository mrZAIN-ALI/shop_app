import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class Cart_Item extends StatelessWidget {
  final id;
  final price;
  final quantity;
  final title;
  final mapKey;

  Cart_Item(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.title,
      required this.mapKey});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      //
      child: Dismissible(
        key: ValueKey(id),
        background: Container(
          margin: EdgeInsets.all(20),
          color: Theme.of(context).colorScheme.secondary,
          child: Icon(
            Icons.delete,
            size: 40,
            color: Theme.of(context).colorScheme.error,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<Cart>(
            context,
            listen: false
          ).removeItem(mapKey);
        },
        //
        child: Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(10),
            // child: Text(title,style: TextStyle(fontSize: 39),),
            child: ListTile(
              textColor: Theme.of(context).colorScheme.onSurface,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: FittedBox(
                    child: Text(
                      "\$$price",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
              title: Text(title),
              subtitle: Text("Total: \$ ${price * quantity}"),
              trailing: Text("$quantity x"),
            ),
          ),
        ),
      ),
    );
  }
}
