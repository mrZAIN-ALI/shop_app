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
        child: Row(
         children: [
           IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){
              
            },
          ),
           IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              
            },
          ),
         ],
        ),
        ),
      ),
    );
  }
}
