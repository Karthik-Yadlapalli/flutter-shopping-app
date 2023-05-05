// ignore_for_file: depend_on_referenced_packages, deprecated_member_use
import 'dart:ui';
import 'package:flutter/material.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product detail';
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context)!.settings.arguments as String; // which is id
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);

    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvcGRmbG93ZXJzZXRwcm9qZWN0MTAtYWRqLTM3XzFfMy1sMDRzaHRwMi5qcGc.jpg?s=8bSsGGSQk1ibA4SoSYiUVLDWB1Yi1UIcN7t-R946MzU'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                )),
          ),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(8),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 600,
                  width: 400,
                  child: Hero(
                      tag: productId,
                      child: Image.network(loadedProduct.imageUrl)),
                ),
                const SizedBox(height: 8),
                Text(
                  loadedProduct.title,
                  style: const TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Chip(
                  label: Text(
                    '\$${loadedProduct.price}',
                    style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Theme.of(context).accentColor,
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 15),
                    child: Text(
                      'Description',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      loadedProduct.description,
                      style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 15),
                    child: Text(
                      'Material',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      loadedProduct.material,
                      style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 15),
                    child: Text(
                      'Dimensions',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      loadedProduct.dimensions,
                      style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 15),
                    child: Text(
                      'Care Instructions',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      loadedProduct.careInstruction,
                      style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 15),
                    child: Text(
                      'Shipping and Return Details',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      loadedProduct.shipping_return_details,
                      style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          Positioned(
              top: 6,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.black, size: 24),
              )),
        ]),
      ),
    );
  }
}
