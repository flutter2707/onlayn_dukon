import 'package:flutter/cupertino.dart';
import 'package:onlayn_dukon/screens/cart_screens.dart';
import 'package:provider/provider.dart' show Consumer, Provider;
import 'package:flutter/material.dart';

import '../providers/cart.dart';
import '../providers/products.dart';

class ProductDetalScreen extends StatelessWidget {
  const ProductDetalScreen({super.key,});

  static const routName = '/product-details';

  @override
  Widget build(BuildContext context) {

    final productId = ModalRoute.of(context)!.settings.arguments;
    final product = Provider.of<Products>(context,listen: false).findById
      (productId as
    String);
    final products = Provider.of<Products>(context).list;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.chevron_left,size: 28,color: Colors.white,),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text(product.title,style: const TextStyle(
            color: Color(0xffeff0f1)
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 2 / 5,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft:
                    Radius.circular(20)),
                    child: Image.network(product.imageURL,fit: BoxFit.fill,))),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(product.description,style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700
              ),),
            ),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Price:',style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16
                ),),
                Text('\$${product.price}',style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  fontWeight: FontWeight.bold
                ),)
              ],
            ),
            Consumer<Cart>(
              builder: (context, cart, child) {
                final isProductAdded = cart.items.containsKey(productId);
                if(isProductAdded) {
                  return ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pushNamed(CartScreens.routName),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(horizontal: 25,
                            vertical: 12),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                      // elevation: 0
                    ),
                    icon: const Icon(Icons.shopping_bag_outlined,
                      size: 18,
                      color: Colors.black,),
                    label: const Text('Go to cart',style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    ),),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () => cart.addToCart(productId, product.title,
                        product.imageURL, product.price),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(horizontal: 25,
                            vertical: 12),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    ),
                    child: const Text('Add to cart', style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    ),),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
