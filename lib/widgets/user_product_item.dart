import 'package:flutter/material.dart';
import 'package:onlayn_dukon/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  UserProductItem({super.key});


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
    final product = Provider.of<Product>(context);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.imageURL),
        ),
        title: Text(product.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,
                      arguments: product.id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
                onPressed: () {
                  _notifyUserAboutDelete(context, () {
                    Provider.of<Products>(context, listen: false)
                        .deleteProduct(product.id);
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ))
          ],
        ),
      ),
    );
  }
}
