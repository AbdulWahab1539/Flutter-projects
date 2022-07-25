import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String productId;
  final String id;
  final String title;
  final double price;
  final int qty;

  const CartItem(this.productId, this.id, this.title, this.price, this.qty);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (isDismissed) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Remove Item'),
            content: Text('Do you want to remove this item?'),
            actions: [
              FlatButton(onPressed: () => Navigator.of(context).pop(false), child: Text('No')),
              FlatButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Yes')),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: CircleAvatar(
                  child: Text(
                    '\$$price',
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${price * qty}'),
            trailing: Text('$qty x'),
          ),
        ),
      ),
    );
  }
}
