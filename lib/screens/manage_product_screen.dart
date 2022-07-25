import 'package:flutter/material.dart';


class ManageProductScreen extends StatefulWidget {
  static const routeName = '/manage-products';

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Product'),
      ),
      body: Container(),
    );
  }
}
