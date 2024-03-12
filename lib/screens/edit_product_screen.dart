import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _form = GlobalKey<FormState>();
  final _imageForm = GlobalKey<FormState>();

  final _priceFocus = FocusNode();
  var _product = Product(id: '', title: '', description: '', price: 0.0,
      imageURL: '');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _priceFocus.dispose();
  }
  var _init = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(_init) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      if(productId != null) {
        final _editingProduct = Provider.of<Products>(context).findById(productId as String);
        _product = _editingProduct;
      }
    }
    _init = false;
  }

  void _showImageDialog(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('Enter image url!'),
        content: Form(
          key: _imageForm,
          child: TextFormField(
            initialValue: _product.imageURL,
            decoration: const InputDecoration(
                label: Text('Image Url'),
                border: OutlineInputBorder()
            ),
            keyboardType: TextInputType.url,
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'please, enter image url';
              } else if(!value.startsWith('http')) {
                return 'please, enter the image url correctly';
              }
            },
            onSaved: (newValue) {
              _product = Product(id: _product.id, title: _product.title,
                  description:
              _product.description, price: _product.price, imageURL:
              newValue!,
              isFavorite: _product.isFavorite
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop();
            FocusScope.of(context).unfocus();
          }, child: const
          Text('cancel',style: TextStyle(
              fontSize: 18
          ),)),
          const SizedBox(width: 55,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: _saveImageForm, child: const Text('add',style: TextStyle(
              fontSize: 20
          ),))
        ],
      );
    },);
  }

  var _hasImage = true;

  void _saveImageForm() {

    final isValid = _imageForm.currentState!.validate();
    if(isValid) {
      _imageForm.currentState!.save();
      print(_product.imageURL);
      setState(() {
        _hasImage = true;
      });
      Navigator.of(context).pop();
      FocusScope.of(context).unfocus();
    }
  }

  void _saveForm() {
    FocusScope.of(context).unfocus();
    final isValid = _form.currentState!.validate();
    setState(() {
      _hasImage = _product.imageURL.isNotEmpty;
    });
    if(isValid && _hasImage) {
      _form.currentState!.save();
      if(_product.id.isEmpty) {
        setState(() {
          Provider.of<Products>(context,listen: false).addProduct(_product);
        });
      } else {
        setState(() {
          Provider.of<Products>(context,listen: false).updateProduct(_product);
        });
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Add product'),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 28
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(
              Icons.save,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextFormField(
                  initialValue: _product.title,
                  decoration: const InputDecoration(
                      label: Text('Name'),
                      border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  // onFieldSubmitted: (_) {
                  //   FocusScope.of(context).requestFocus(_priceFocus);
                  // },
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'please enter the product name';
                    }
                  },
                  onSaved: (newValue) {
                    _product = Product(
                        id: _product.id,
                        title: newValue!,
                        description: _product.description,
                        price: _product.price,
                        imageURL: _product.imageURL,
                        isFavorite: _product.isFavorite
                    );
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  initialValue: _product.price == 0 ? '' : _product.price
                      .toStringAsFixed(2),
                  decoration: const InputDecoration(
                      label: Text('Price'),
                      border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocus,
                  textInputAction: TextInputAction.next,
                  // onFieldSubmitted: (_) {
                  //   FocusScope.of(context).requestFocus(_priceFocus);
                  // },
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'please enter the product price';
                    } else if(double.tryParse(value) == null) {
                      return 'please enter the correct price';
                  } else if(double.parse(value) < 1) {
                      return 'product price cannot be less than 1';
                    }
                  },
                  onSaved: (newValue) {
                    _product = Product(id: _product.id, title: _product.title, description:
                    _product.description, price: double.parse(newValue!), imageURL:
                    _product.imageURL,
                    isFavorite: _product.isFavorite
                    );
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  initialValue: _product.description,
                  decoration: const InputDecoration(
                      label: Text('Additional Information'),
                      border: OutlineInputBorder(),
                    alignLabelWithHint: true
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onSaved: (newValue) {
                    _product = Product(id: _product.id, title: _product.title, description:
                    newValue!, price: _product.price, imageURL:
                    _product.imageURL,
                    isFavorite: _product.isFavorite
                    );
                  },
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'please enter a product description';
                    } else if(value.length < 10) {
                      return 'Please enter product details';
                    }
                  },
                ),
                const SizedBox(height: 10,),
                Card(
                  margin: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: _hasImage ? Colors.grey :
                      Theme.of(context).errorColor),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: InkWell(
                    onTap: () {
                      _showImageDialog(context);
                      FocusScope.of(context).unfocus();
                    },
                    splashColor: Colors.teal.shade700,
                    hoverDuration: const Duration(seconds: 3),
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: _product.imageURL.isEmpty ? Text('Enter the main '
                      'image url',
                      style:
                      TextStyle(
                        color: _hasImage ? Colors.black : Theme.of(context).errorColor,
                        fontSize: 16,
                      ),
                      ) : Image.network(_product.imageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
