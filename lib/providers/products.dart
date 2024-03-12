import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class Products with ChangeNotifier {
  final List<Product> _list = [
    Product(
        id: 'p1',
        title: 'MacBook Pro',
        description: 'Ajoyib MacBook Pro - bu juda ham ajoyib',
        price: 1900,
        imageURL:
            'https://gadgetstore.kz/wa-data/public/shop/products/56/05/556/images/1939/1939.970.jpeg'),
    Product(
        id: 'p2',
        title: 'AirPots i12',
        description: 'Ajoyib AirPots i12 - bu juda ham ajoyib',
        price: 65,
        imageURL:
            'https://s.alicdn.com/@sc04/kf/H6c46c7fb1bb34df78343b662d451adebC.jpg_300x300.jpg'),
    Product(
        id: 'p3',
        title: 'iPhone 15 Pro Max',
        description: 'Ajoyib iPhone 15 Pro Max - bu juda ham ajoyib',
        price: 1000,
        imageURL:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNAFRjrLJtkxcmCvpiuVNRwvSCAEZSX4oy8Q&usqp=CAU'),
    Product(
        id: 'p4',
        title: 'Apple watch',
        description: 'Ajoyib Apple watch - bu juda ham ajoyib',
        price: 90,
        imageURL:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTITmjGqlK-GKehtb8t7CSl7Efgb9vuiXf7wA&usqp=CAU'),
    Product(
        id: 'p5',
        title: 'Acer Predator',
        description: 'Ajoyib Acer Predator - bu juda ham ajoyib',
        price: 800,
        imageURL:
            'https://nout.uz/wp-content/uploads/2023/03/predator-300-helios-1.jpg'),
    Product(
        id: 'p6',
        title: 'ASUS TUF',
        description: 'Ajoyib ASUS TUF - bu juda ham ajoyib',
        price: 1200,
        imageURL:
            'https://sg.store.asus.com/media/catalog/product/cache/4626358af9c1ade436cccb840a9a8542/p/r/product-photos-fa507_1_2.png'),
  ];

  List<Product> get list {
    return [..._list];
  }

  List<Product> get favorites {
    return _list.where((product) => product.isFavorite).toList();
  }

  void addProduct(Product product) {
    final url = Uri.parse(
        'https://online-shopping-77b2c-default-rtdb.firebaseio.com/products.json');
    http.post(
      url,
      body: jsonEncode(
        {
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageURL': product.imageURL,
          'isFavorite': product.isFavorite
        },
      ),
    );
    final newProduct = Product(
        id: UniqueKey().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageURL: product.imageURL);

    _list.insert(0, newProduct);
    notifyListeners();
  }

  Product findById(String productId) {
    return _list.firstWhere((element) => element.id == productId);
  }

  void updateProduct(Product updateProduct) {
    final url = Uri.parse(
        'https://online-shopping-77b2c-default-rtdb.firebaseio.com/products.json');
    http.put(
      url,
      body: jsonEncode(
        {
          'title': updateProduct.title,
          'description': updateProduct.description,
          'price': updateProduct.price,
          'imageURL': updateProduct.imageURL,
          'isFavorite': updateProduct.isFavorite
        },
      ),
    );
    final productIndex =
        _list.indexWhere((product) => product.id == updateProduct.id);
    if (productIndex >= 0) {
      _list[productIndex] = updateProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final url = Uri.parse(
        'https://online-shopping-77b2c-default-rtdb.firebaseio.com/products.json');
    http.delete(
      url,
      body: jsonEncode(
        {
          'id' : id
        },
      ),
    );
    _list.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
