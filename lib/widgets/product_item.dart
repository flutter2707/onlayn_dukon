import 'package:flutter/material.dart';
import 'package:onlayn_dukon/providers/cart.dart';
import 'package:provider/provider.dart' show Consumer, Provider;

import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<Product>(
                    builder: (context, pro, child) {
                      return IconButton(
                          onPressed: () {
                            pro.toggleFavorite();
                          },
                          icon: pro.isFavorite
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_outline_sharp,
                                  color: Colors.teal,
                                ));
                    },
                  ),
                  Text(
                    product.title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                      onPressed: () {
                        cart.addToCart(product.id, product.title,
                            product.imageURL, product.price);
                        // ScaffoldMessenger.of(context)
                        //     .hideCurrentMaterialBanner();
                        // ScaffoldMessenger.of(context).showMaterialBanner(
                        //   MaterialBanner(
                        //     backgroundColor: Colors.grey.shade700,
                        //     content: const Text(
                        //       'Added to cart',
                        //       style:
                        //       TextStyle(color: Colors.white, fontSize: 18),
                        //     ),
                        //     actions: [
                        //       TextButton(
                        //         onPressed: () {
                        //           cart.removeToCart(product.id,
                        //               isCartButton: true);
                        //           ScaffoldMessenger.of(context)
                        //               .hideCurrentMaterialBanner();
                        //         },
                        //         child: Text(
                        //           'cancel'.toUpperCase(),
                        //           style: const TextStyle(color: Colors.white),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // );
                        // Future.delayed(
                        //   const Duration(seconds: 2),
                        //   () => ScaffoldMessenger.of(context)
                        //       .hideCurrentMaterialBanner(),
                        // );
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Added to cart',style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white
                                ),),
                                duration: const Duration(seconds: 5),
                                action: SnackBarAction(
                                  onPressed: () {
                                    cart.removeToCart(
                                        product.id,
                                        isCartButton: true
                                    );
                                  },
                                  label: 'cancel'.toUpperCase(),
                                ),
                              ),
                            );
                          },
                      icon: const Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.teal,
                      ))
                ],
              ),
            ),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ProductDetalScreen.routName,
                      arguments: product.id);
                },
                child: Image.network(
                  product.imageURL,
                  fit: BoxFit.cover,
                )),
          ),
        ));
  }
}
