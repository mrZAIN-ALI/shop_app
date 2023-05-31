import 'package:flutter/material.dart';

class UseerProductItem extends StatelessWidget {
  final title;
  final imgUrl;
  const UseerProductItem({this.title, this.imgUrl});

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
