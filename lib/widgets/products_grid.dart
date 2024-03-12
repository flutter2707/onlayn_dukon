import 'package:flutter/material.dart';
import 'package:onlayn_dukon/widgets/product_item.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, Provider;
import '../models/product.dart';
import '../providers/products.dart';


class ProductsGrid extends StatelessWidget {
  final bool showFavorites;
  const ProductsGrid(this.showFavorites,{super.key,});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavorites ? productsData.favorites : productsData.list;
    return GridView.builder(
      restorationId: '10',
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider<Product>.value(
          value: products[index],
          child: const ProductItem(),
        );
      },);
  }
}
