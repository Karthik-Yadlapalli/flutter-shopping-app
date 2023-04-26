// ignore_for_file: avoid_print, depend_on_referenced_packages, use_build_context_synchronously
import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});
  static const routeName = '/edit_product';
  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _priceFocuseNode = FocusNode();
  final _descriptionFocuseNode = FocusNode();
  final _materialFocusNode = FocusNode();
  final _careFocusNode = FocusNode();
  final _dimensionFocusNode = FocusNode();
  final _shippingReturnFocusNode = FocusNode();
  final _imgUrlFocusNode = FocusNode();
  final _imgUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  // ignore: prefer_final_fields

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
    'shipping': '',
    'care': '',
    'material': '',
    'dimensions': '',
  };

  var _editedProduct = Product(
      id: '',
      title: '',
      description: '',
      price: 0,
      careInstruction: '',
      dimensions: '',
      shipping_return_details: '',
      material: '',
      imageUrl: '');

  @override
  void dispose() {
    _descriptionFocuseNode.dispose();
    _priceFocuseNode.dispose();
    _materialFocusNode.dispose();
    _careFocusNode.dispose();
    _dimensionFocusNode.dispose();
    _shippingReturnFocusNode.dispose();
    _imgUrlController.dispose();
    _imgUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  @override
  void initState() {
    _imgUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findById(productId as String);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
          'care': _editedProduct.careInstruction,
          'dimensions': _editedProduct.dimensions,
          'material': _editedProduct.material,
          'shipping': _editedProduct.shipping_return_details
        };
        _imgUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      if (_imgUrlController.text.isEmpty ||
          (!_imgUrlController.text.startsWith('http') &&
              !_imgUrlController.text.startsWith('https')) ||
          ((!_imgUrlController.text.endsWith('.jpg') &&
              (!_imgUrlController.text.endsWith('.png') &&
                  (!_imgUrlController.text.endsWith('.jpeg')))))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != '') {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("An error occured"),
                  content: Text(error.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Okay'))
                  ],
                ));
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      ///Title Field///
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        initialValue: _initValues['title'].toString(),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocuseNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              isFavourite: _editedProduct.isFavourite,
                              dimensions: _editedProduct.dimensions,
                              shipping_return_details:
                                  _editedProduct.shipping_return_details,
                              material: _editedProduct.material,
                              careInstruction: _editedProduct.careInstruction,
                              id: _editedProduct.id,
                              description: _editedProduct.description,
                              title: value!,
                              imageUrl: _editedProduct.imageUrl,
                              price: _editedProduct.price);
                        },
                      ),

                      ///Price Field///
                      TextFormField(
                        initialValue: _initValues['price'].toString(),
                        decoration: const InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocuseNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocuseNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide the price';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Enter valide number';
                          }
                          if (double.parse(value) <= 0) {
                            return 'price must be grater than 0';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              isFavourite: _editedProduct.isFavourite,
                              dimensions: _editedProduct.dimensions,
                              shipping_return_details:
                                  _editedProduct.shipping_return_details,
                              material: _editedProduct.material,
                              careInstruction: _editedProduct.careInstruction,
                              id: _editedProduct.id,
                              description: _editedProduct.description,
                              title: _editedProduct.title,
                              imageUrl: _editedProduct.imageUrl,
                              price: double.parse(value!));
                        },
                      ),

                      ///Description Field///
                      TextFormField(
                        initialValue: _initValues['description'].toString(),
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        maxLines: 4,
                        maxLength: 150,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocuseNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a descreption';
                          }
                          if (value.length < 10) {
                            return 'Descreption must atleast 10 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              isFavourite: _editedProduct.isFavourite,
                              dimensions: _editedProduct.dimensions,
                              shipping_return_details:
                                  _editedProduct.shipping_return_details,
                              material: _editedProduct.material,
                              careInstruction: _editedProduct.careInstruction,
                              id: _editedProduct.id,
                              description: value!,
                              title: _editedProduct.title,
                              imageUrl: _editedProduct.imageUrl,
                              price: _editedProduct.price);
                        },
                      ),

                      ///Material Field///
                      TextFormField(
                          initialValue: _initValues['material'].toString(),
                          decoration:
                              const InputDecoration(labelText: 'Material'),
                          //maxLines: 3,
                          textInputAction: TextInputAction.next,
                          //keyboardType: TextInputType.multiline,
                          focusNode: _materialFocusNode,
                          onSaved: (value) {
                            _editedProduct = Product(
                                isFavourite: _editedProduct.isFavourite,
                                dimensions: _editedProduct.dimensions,
                                shipping_return_details:
                                    _editedProduct.shipping_return_details,
                                material: value!,
                                careInstruction: _editedProduct.careInstruction,
                                id: _editedProduct.id,
                                description: _editedProduct.description,
                                title: _editedProduct.title,
                                imageUrl: _editedProduct.imageUrl,
                                price: _editedProduct.price);
                          }),

                      ///Care Instructions///
                      TextFormField(
                          initialValue: _initValues['care'].toString(),
                          decoration: const InputDecoration(
                              labelText: 'Care Instructions'),
                          //maxLines: 3,
                          textInputAction: TextInputAction.next,
                          //keyboardType: TextInputType.multiline,
                          focusNode: _careFocusNode,
                          onSaved: (value) {
                            _editedProduct = Product(
                                isFavourite: _editedProduct.isFavourite,
                                dimensions: _editedProduct.dimensions,
                                shipping_return_details:
                                    _editedProduct.shipping_return_details,
                                material: _editedProduct.material,
                                careInstruction: value!,
                                id: _editedProduct.id,
                                description: _editedProduct.description,
                                title: _editedProduct.title,
                                imageUrl: _editedProduct.imageUrl,
                                price: _editedProduct.price);
                          }),

                      ///Dimensions Field///
                      TextFormField(
                          initialValue: _initValues['dimensions'].toString(),
                          decoration:
                              const InputDecoration(labelText: 'Dimensions'),
                          //maxLines: 3,
                          textInputAction: TextInputAction.next,
                          //keyboardType: TextInputType.multiline,
                          focusNode: _dimensionFocusNode,
                          onSaved: (value) {
                            _editedProduct = Product(
                                isFavourite: _editedProduct.isFavourite,
                                dimensions: value!,
                                shipping_return_details:
                                    _editedProduct.shipping_return_details,
                                material: _editedProduct.material,
                                careInstruction: _editedProduct.careInstruction,
                                id: _editedProduct.id,
                                description: _editedProduct.description,
                                title: _editedProduct.title,
                                imageUrl: _editedProduct.imageUrl,
                                price: _editedProduct.price);
                          }),

                      ///Shipping Details Field///
                      TextFormField(
                          initialValue: _initValues['shipping'].toString(),
                          decoration: const InputDecoration(
                              labelText: 'Shipping and return details'),
                          maxLines: 3,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                          focusNode: _shippingReturnFocusNode,
                          onSaved: (value) {
                            _editedProduct = Product(
                                isFavourite: _editedProduct.isFavourite,
                                dimensions: _editedProduct.dimensions,
                                shipping_return_details: value!,
                                material: _editedProduct.material,
                                careInstruction: _editedProduct.careInstruction,
                                id: _editedProduct.id,
                                description: _editedProduct.description,
                                title: _editedProduct.title,
                                imageUrl: _editedProduct.imageUrl,
                                price: _editedProduct.price);
                          }),

                      ///Image Url Field///
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.grey)),
                            child: _imgUrlController.text.isNotEmpty
                                ? Image.network(_imgUrlController.text)
                                : const Text('Enter Url'),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'ImageUrl'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imgUrlController,
                              focusNode: _imgUrlFocusNode,
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter an image URL.';
                                }
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return 'Please enter a valid URL.';
                                }
                                if (!value.endsWith('.png') &&
                                    !value.endsWith('.jpg') &&
                                    !value.endsWith('.jpeg')) {
                                  return 'Please enter a valid image URL.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedProduct = Product(
                                    isFavourite: _editedProduct.isFavourite,
                                    dimensions: _editedProduct.dimensions,
                                    shipping_return_details:
                                        _editedProduct.shipping_return_details,
                                    material: _editedProduct.material,
                                    careInstruction:
                                        _editedProduct.careInstruction,
                                    id: _editedProduct.id,
                                    description: _editedProduct.description,
                                    title: _editedProduct.title,
                                    imageUrl: value!,
                                    price: _editedProduct.price);
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
