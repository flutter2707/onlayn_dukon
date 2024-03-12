import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/manage_product_screen.dart';
import './screens/orders_screen.dart';
import './styles/my_shop_style.dart';
import './screens/edit_product_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './screens/cart_screens.dart';
import './screens/main_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ThemeData theme = MyShopStyle.style;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (context)=> Products(),),
        ChangeNotifierProvider<Cart>(
          create: (context)=> Cart(),),
        ChangeNotifierProvider<Orders>(
          create: (context)=> Orders(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme,
        initialRoute: MainScreen.routName,
        routes: {
          MainScreen.routName: (context) => const MainScreen(),
          ProductDetalScreen.routName: (context) => const ProductDetalScreen(),
          CartScreens.routName: (context) => CartScreens(),
          OrdersScreen.routName: (context) => const OrdersScreen(),
          ManageProductScreen.routeName: (context) => ManageProductScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen()
        },
      ),
    );
  }
}