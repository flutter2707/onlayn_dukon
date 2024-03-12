import 'package:flutter/material.dart';
import 'package:onlayn_dukon/widgets/order_item.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widgets/app_drawer.dart';
import '../providers/orders.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static String routName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Orders'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (context, index) {
          final order = orders.items[index];
          return OrderItem(totalPrice: order.totalPrice, date: order.date,
            products: order.product,);
        },
      ),
    );
  }
}
