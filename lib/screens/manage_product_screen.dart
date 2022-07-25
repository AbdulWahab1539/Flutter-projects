import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class ManageProductScreen extends StatefulWidget {
  static const routeName = '/manage-products';

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    imageUrl: '',
    price: 0.0,
  );
  final _imageUrlController = TextEditingController();
  var _isInit = true;

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) return;
    final productId = ModalRoute.of(context).settings.arguments as String;
    if (productId == null) return;
    _editedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    _imageUrlController.text =
        _editedProduct.imageUrl.isEmpty ? '' : _editedProduct.imageUrl;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      final value = _imageUrlController.text;
      if (value.isEmpty ||
          (!value.startsWith('http') && !value.startsWith('https')) ||
          (!value.endsWith('.png') &&
              !value.endsWith('jpeg') &&
              !value.endsWith('jpg'))) return;
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();
    if (_editedProduct.id == null)
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    else
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Title'),
                ),
                initialValue:
                    _editedProduct.title.isEmpty ? '' : _editedProduct.title,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) return 'Please fill this field';
                  return null;
                },
                onSaved: (value) => _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                    title: value,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl),
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Price'),
                ),
                initialValue: _editedProduct.price == 0.0
                    ? '0.0'
                    : _editedProduct.price.toString(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                validator: (value) {
                  if (value.isEmpty) return 'Please fill this field';
                  if (double.tryParse(value) == null)
                    return 'Please enter a valid number';
                  if (double.tryParse(value) <= 0)
                    return 'Price cannot be less than or equal to 0';
                  return null;
                },
                onSaved: (value) => _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value),
                    imageUrl: _editedProduct.imageUrl),
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Description'),
                ),
                initialValue: _editedProduct.description.isEmpty
                    ? ''
                    : _editedProduct.description,
                maxLines: 3,
                focusNode: _descFocusNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value.isEmpty) return 'Please fill this field';
                  if (value.length < 10)
                    return 'Description should be 10 characters long.';
                  return null;
                },
                onSaved: (value) => _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                    title: _editedProduct.title,
                    description: value,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a Url')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text('Image Url'),
                      ),
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      keyboardType: TextInputType.url,
                      focusNode: _imageUrlFocusNode,
                      validator: (value) {
                        if (value.isEmpty) return 'Please fill this field';
                        if (!value.startsWith('http') &&
                            !value.startsWith('https'))
                          return 'Please enter a valid Url starts with http';
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpeg') &&
                            !value.endsWith('.jpg'))
                          return 'Please enter a valid URL ends with jpg/png/jpeg';
                        return null;
                      },
                      onSaved: (value) => _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value),
                      onFieldSubmitted: (_) => _saveForm(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
