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
  final _imageUrlController = TextEditingController();
  final _ImageUrlFocuNode=FocusNode();

  
  String _imgUrl = "";
  void dispose() {
    _ImageUrlFocuNode.removeListener(_updatImageurlFun);
    _priceFocusNode.dispose();
    _descriptionNOde.dispose();
    _imageUrlController.dispose();
    _ImageUrlFocuNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _ImageUrlFocuNode.addListener(_updatImageurlFun);
    super.initState();
  }
  void _updatImageurlFun(){
    if(!_ImageUrlFocuNode.hasFocus){
      setState(() {
        
      });
    }
  }
  // void updateImageUrl() {
  //   if (!_imageUrlController.text.isEmpty) {
  //     setState(() {
  //       _imgUrl = _imageUrlController.text;
  //     });
  //   }
  // }

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    child: Container(
                      child: _imageUrlController.text.isEmpty
                          ? const Center(
                              child: Text(
                                "Enter Url to load image",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : FittedBox(
                              child: Image.network(
                                 _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        labelText: "Image Url",
                      ),
                      controller: _imageUrlController,
                      focusNode: _ImageUrlFocuNode,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
