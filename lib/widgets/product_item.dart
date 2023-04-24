// ignore_for_file: depend_on_referenced_packages

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';

class ProductItemCard extends StatefulWidget {
  const ProductItemCard({super.key});
  @override
  State<ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    bool isCarted = cart.toggleCart(product.id);

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        height: 300,
        width: 300,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(colors: [
              Colors.white.withAlpha(100),
              Colors.black.withAlpha(100)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Card(
            elevation: 8,
            surfaceTintColor: const Color.fromARGB(255, 206, 66, 51),
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                ProductDetailScreen.routeName,
                                arguments: product.id);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Hero(
                              tag: product.id,
                              child: Image.network(
                                product.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    product.title,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    // style: const TextStyle(
                                    //     color: Colors.white,
                                    //     fontSize: 18,
                                    //     fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Text(
                                product.description,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      "\$ ${product.price}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cart.addItem(
                              product.id, product.title, product.price);
                          Provider.of<Orders>(context, listen: false).addOrders(
                              cart.item.values.toList(),
                              double.parse(cart.totalAmt));
                          cart.clear();
                          Navigator.of(context).pushNamed('/orders');
                        },
                        child: Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.greenAccent[700]),
                          child: const Center(child: Text('Buy Now')),
                        ),
                      ),
                      const SizedBox(width: 14),
                      GestureDetector(
                        onTap: () {
                          cart.addItem(
                              product.id, product.title, product.price);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Added to Cart!'),
                            duration: const Duration(seconds: 4),
                            action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  cart.removeSingleItem(product.id);
                                }),
                          ));
                        },
                        child: isCarted
                            ? Container(
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.greenAccent[700]),
                                child: const Center(child: Text('Add to Cart')),
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/cart');
                                },
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.greenAccent[700]),
                                  child: const Center(child: Text('GoTo Cart')),
                                ),
                              ),
                      ),
                      const SizedBox(width: 14),
                      Consumer<Products>(
                        builder: (context, value, child) => GestureDetector(
                            onTap: product.toggleFavourite,
                            child: Icon(
                              product.isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.greenAccent[700],
                            )),
                      )
                    ],
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
