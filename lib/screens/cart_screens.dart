import 'package:flutter/material.dart';
import 'package:onlayn_dukon/providers/cart.dart';
import 'package:onlayn_dukon/providers/orders.dart';
import 'package:onlayn_dukon/widgets/cart_list_item.dart';
import 'package:provider/provider.dart';

class CartScreens extends StatelessWidget {
  CartScreens({super.key});

  static const routName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 28,
          ),
        ),
        title: const Text('Your shopping cart'),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 28, color: Colors.white),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Common: ',
                    style: TextStyle(fontSize: 22, color: Colors.teal),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context,listen: false).addToOrder(
                          cart.items.values.toList(), cart.totalPrice);
                      cart.clearCart();
                    },
                    child: const Text(
                      'Make an order',
                      style: TextStyle(color: Colors.teal, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final cartItem = cart.items.values.toList()[index];
              return CartListItem(
                  productId: cart.items.keys.toList()[index],
                  imageURL: cartItem.image,
                  title: cartItem.title,
                  price: cartItem.price,
                  quantity: cartItem.quantity
              );
            },
          ))
        ],
      ),
    );
  }
}
