import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UseerProductItem extends StatelessWidget {
  final title;
  final imgUrl;
  final id;
  const UseerProductItem({this.title, this.imgUrl,this.id});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),

      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imgUrl),
    
        ),
        trailing: Container(
          width: 100,
        child: Row(
         children: [
           IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){
              Navigator.of(context).pushNamed(EditPrudcutScreen.routeName,arguments: id);
            },

            color: Theme.of(context).colorScheme.primary,
          ),
           SizedBox(width: 10.0),
           IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              
            },
            color: Theme.of(context).colorScheme.error,
          ), 
         ],
        ),
        ),
      ),
    );
  }
}
