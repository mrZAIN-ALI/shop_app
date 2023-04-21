import 'package:flutter/material.dart';

class Cart_Item extends StatelessWidget {
  final id;
  final price;
  final quantity;
  final title;

  Cart_Item({this.id, this.price, this.quantity, this.title});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          // child: Text(title,style: TextStyle(fontSize: 39),),
          child: ListTile(
            textColor: Theme.of(context).colorScheme.onPrimary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            leading: CircleAvatar(
              radius: 30,
              // backgroundColor: Theme.of(context).colorScheme.primary,
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
    );
  }
}
