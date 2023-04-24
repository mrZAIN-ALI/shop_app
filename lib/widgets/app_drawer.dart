import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Column(
      children: [
        AppBar(title: Text("Hello"),automaticallyImplyLeading: false,),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text("Shop"),
          onTap:(){
             Navigator.of(context).pushNamed("/")
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text("Orders"),
          onTap:(){
             Navigator.of(context).pushNamed("/")
          },
        ),
      ],
    ),);
  }
}