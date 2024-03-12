import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/card_item.dart';
import '../models/order.dart';

class OrderItem extends StatefulWidget {
  final double totalPrice;
  final DateTime date;
  final List<CartItem> products;
  const OrderItem({super.key,
    required this.totalPrice,
    required this.date,
    required this.products
  });

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expandItem = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.totalPrice}',style: const TextStyle(
                color: Colors.black
            ),),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.date),style:
            const TextStyle(
                color: Colors.black
            ),),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expandItem = !_expandItem;
                });
              },
              icon: Icon(_expandItem ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if(_expandItem)Container(
              height: min(widget.products.length * 10 + 40, 100),
              child: ListView.builder(
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.products[index].title),
                    trailing: Text('${widget.products[index].quantity}x \$'
                        '${widget.totalPrice}',style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12
                    ),),
                  );
                },
              ),
            )
        ],
      ),
    );;
  }
}
