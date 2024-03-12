import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products.dart';

class ManageProductScreen extends StatelessWidget {
  const ManageProductScreen({super.key});

  static const routeName = '/manage-products';

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Product management'),
        titleTextStyle: const TextStyle(
            fontSize: 28, color: Colors.white, fontWeight: FontWeight.w700),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add,color: Colors.white,weight: 35,))
        ],
        centerTitle: true,
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(12),
        itemCount: productProvider.list.length,
        itemBuilder: (context, index) {
          final product = productProvider.list[index];
          return ChangeNotifierProvider.value(
              value: product, child: UserProductItem());
        },
      ),
    );
  }
}
