import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../providers/cart.dart';

class CartListItem extends StatelessWidget {
  final String productId;
  final String imageURL;
  final String title;
  final double price;
  final int quantity;
  CartListItem(
      {super.key,
      required this.productId,
      required this.imageURL,
      required this.title,
      required this.price,
      required this.quantity});

  void _notifyUserAboutDelete(BuildContext context,Function() removeItem) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('removing this product from the cart'),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(),
                child:
                const Text('cancel',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16
                ),),
              ),
              const Spacer(),
              const SizedBox(width: 50,),
              ElevatedButton(
                onPressed: removeItem,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).errorColor
                ),
                child: const Text
                ('Delete',style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),),),
            ],
          );
        },);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Slidable(
      key: ValueKey(productId),
      endActionPane: ActionPane(
        extentRatio: 0.27,
        dragDismissible: true,
        motion: const ScrollMotion(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            child: ElevatedButton(
                onPressed: () => _notifyUserAboutDelete(
                  context,
                  () {
                    cart.removeItem(productId);
                    Navigator.of(context).pop();
                  },
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffa21035),
                  padding: const EdgeInsets.symmetric(horizontal: 20,
                      vertical: 25),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
                ),
              child: const Text('delete',style: TextStyle(
                  color: Colors.white,
                fontSize: 18
              ),),
            ),
          )
        ],
      ),
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(imageURL),
          ),
          title: Text(title,style: const TextStyle(
            color: Colors.teal,
          ),),
          subtitle: Text('Common: \$${(price * quantity).toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.teal.shade300,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  splashRadius: 15,
                  onPressed: () => cart.removeToCart(productId),
                  icon: const Icon(Icons.remove,color: Colors.black,)),
              Text('$quantity',style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16
              ),),
              IconButton(
                  splashRadius: 15,
                  onPressed: () =>
                      cart.addToCart(productId, title, imageURL, price),
                  icon: const Icon(Icons.add,color: Colors.black,))
            ],
          ),
        ),
      ),
    );
  }
}
