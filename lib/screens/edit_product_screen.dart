import 'package:flutter/material.dart';

class EditPrudcutScreen extends StatefulWidget {
  // const EditPrudcutScreen({super.key});
  static const routeName = "/edit-product-screen";
  @override
  State<EditPrudcutScreen> createState() => _EditPrudcutScreenState();
}

class _EditPrudcutScreenState extends State<EditPrudcutScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionNOde = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Price",
                ),
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionNOde);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionNOde,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
