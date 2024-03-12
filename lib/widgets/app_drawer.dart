import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/main_screen.dart';
import '../screens/manage_product_screen.dart';
import '../screens/orders_screen.dart';
import '../providers/cart.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,

      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.teal,
            title: const Text('Hello friend!',style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold
            ),),
          ),
          ListTile(
            leading: Icon(Icons.shop,color: Colors.black,),
            title: Text('Shopping',style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),),
            onTap: () => Navigator.of(context).pushReplacementNamed(MainScreen.routName),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.payment_outlined,color: Colors.black,),
            title: Text('Orders',style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),),
            onTap: () => Navigator.of(context).pushReplacementNamed
              (OrdersScreen.routName),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.settings,color: Colors.black),
            title: Text('Product management',style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),),
            onTap: () => Navigator.of(context).pushReplacementNamed(ManageProductScreen.routeName),
          ),
        ],
      ),
    );
  }
}
// Drawer(
//         shadowColor: Colors.white,
//         backgroundColor: dark == false ? Colors.white : Colors.black87,
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: IconButton(onPressed: () {
//                 setState(() {
//                   dark = !dark;
//                 });
//               }, icon: dark == true ? Icon(Icons.dark_mode,color: dark == true ?
//               Colors.white : Colors.black87,) : const Icon
//                 (Icons.dark_mode_outlined)),
//             ),
//             const SizedBox(height: 100,),
//             Row(
//               children: [
//                 SizedBox(width: MediaQuery.of(context).size.width * 0.15,),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: TextButton(onPressed: () {
//
//                   }, child: Text('data1',style: TextStyle(
//                     color: dark == true ? Colors.white : Colors.black87
//                   ),)),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 SizedBox(width: MediaQuery.of(context).size.width * 0.15,),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: TextButton(onPressed: () {
//
//                   }, child: Text('data2',style: TextStyle(
//                       color: dark == true ? Colors.white : Colors.black87
//                   ),)),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 SizedBox(width: MediaQuery.of(context).size.width * 0.15),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: TextButton(onPressed: () {
//
//                   }, child: Text('data3',style: TextStyle(
//                       color: dark == true ? Colors.white : Colors.black87
//                   ),)),
//                 ),
//               ],
//             )
//           ],
//         ),
//       )
