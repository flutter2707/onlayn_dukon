import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onlayn_dukon/screens/cart_screens.dart';
import 'package:onlayn_dukon/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/custom_cart.dart';
import '../widgets/products_grid.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const String routName = '/';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

enum FiltersOption {
  Favorites,
  All
}

class _MainScreenState extends State<MainScreen> {

  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawerEnableOpenDragGesture: true,
      drawer: const AppDrawer(),
      appBar: AppBar(
          title: const Text('Onlayn Shopping'),
          backgroundColor: Colors.teal,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton(
              iconSize: 28,
              iconColor: Colors.white,
              onSelected: (FiltersOption filter) {
                setState(() {
                  if(filter == FiltersOption.All) {
                    // Barchasini ko'rsat
                    _showOnlyFavorites = false;
                  } else {
                    // Sevimlilarni ko'rsat
                    _showOnlyFavorites = true;
                  }
                });
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: FiltersOption.All,
                    child: Text('Barchasi'),
                  ),
                  const PopupMenuItem(
                    value: FiltersOption.Favorites,
                    child: Text('Sevimli'),
                  )
                ];
              },
            ),
            Consumer<Cart>(
              builder: (context, cart, child) {
                return CustomCart(
                    number: cart.itemsCount().toString(),
                    child: child!
                );
              },
              child: IconButton(
                onPressed: () => Navigator.of(context).pushNamed(CartScreens.routName),
                icon: const Icon(Icons.shopping_cart,color: Colors.white,),
              ),
            )
          ]),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
