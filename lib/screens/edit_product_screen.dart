import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../providers/productsModalProvider.dart';
import '../providers/product_Hub.dart';

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
  final _ImageUrlFocuNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: "", title: "", description: "", price: 0, imageUrl: "");
  var initValues = {
    "title": "",
    "description": "",
    "price": "",
    "imageUrl": ""
  };
  var _isInit = true;
  var _isLoading = false;
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

  void _updatImageurlFun() {
    if (!_ImageUrlFocuNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      final _productId = ModalRoute.of(context)?.settings.arguments as String?;
      if (_productId != null) {
        _editedProduct = Provider.of<product_Provider>(context, listen: false)
            .findByid(_productId);
        initValues = {
          "title": _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price.toString(),
          "imageUrl": _editedProduct.imageUrl,
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // void updateImageUrl() {
  //   if (!_imageUrlController.text.isEmpty) {
  //     setState(() {
  //       _imgUrl = _imageUrlController.text;
  //     });
  //   }
  // }
  void _saveFormData() {
    final currentStatofForm = _formKey.currentState;

    setState(
      () {
        _isLoading = true;
      },
    );
    if (currentStatofForm == null) {
      return;
    } else {
      final isValid = currentStatofForm.validate();
      if (!isValid) {
        return null;
      } else {
        currentStatofForm.save();
        if (_editedProduct.id != "") {
          Provider.of<product_Provider>(context, listen: false)
              .updateProduct(_editedProduct.id, _editedProduct);
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        } else {
          Provider.of<product_Provider>(context, listen: false)
              .addProductToLost(_editedProduct)
              .then((value) {
                setState(() {
                  _isLoading=false;
                });
                Navigator.of(context).pop();
              },);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        actions: [
          IconButton(
            onPressed: _saveFormData,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
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
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: newValue!,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Fill the Title Field";
                        } else {
                          return null;
                        }
                      },
                      initialValue: initValues["title"],
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
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(newValue!),
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "Please Fill the Price Field";
                          } else if (double.tryParse(value) == null) {
                            return "Please enter valid numbers.";
                          } else if (double.parse(value) < 0) {
                            return "Please Enter Value greater than zero.";
                          } else {
                            return null;
                          }
                        } else {
                          return "Please Enter non null value.";
                        }
                      },
                      initialValue: initValues["price"],
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Description",
                      ),
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionNOde,
                      maxLines: 3,
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: newValue!,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please Fill non null value.";
                        }
                        if (value.isEmpty) {
                          return "Please Fill in Descriptuion.";
                        } else if (value.length < 10) {
                          return "Please Fill dicription greater  than 10 characters.";
                        } else {
                          return null;
                        }
                      },
                      initialValue: initValues["description"],
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
                            onFieldSubmitted: (_) {
                              _saveFormData();
                            },
                            onSaved: (newValue) {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: newValue!,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                            validator: (value) {
                              if (value == null) {
                                return "Please Fill non null value.";
                              }
                              if (value.isEmpty) {
                                return "Please Fill in Image Url.";
                              } else if (!value.startsWith("https://") &&
                                  !value.startsWith("http://")) {
                                return "It does not seems to be a URL ";
                              } else {
                                return null;
                              }
                            },
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
