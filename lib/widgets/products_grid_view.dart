// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:flutter/material.dart';
import 'package:shop_app/widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/products_provider.dart';

// class ProductGridView extends StatelessWidget {
//   const ProductGridView({super.key, required this.showFav});
//   final bool showFav;

//   @override
//   Widget build(BuildContext context) {
//     final productsData = Provider.of<Products>(context);
//     final products = showFav ? productsData.favouritItems : productsData.item;
//     //final cartItem = Provider.of<Cart>(context);

//     return GridView.builder(
//         padding: const EdgeInsets.all(10.0),
//         itemCount: products.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 30,
//           mainAxisSpacing: 30,
//           childAspectRatio: 4 / 5,
//         ),
//         itemBuilder: (context, index) => ChangeNotifierProvider.value(
//               value: products[index],
//               //create: (context) => products[index],
//               child: const ProductItem(
//                   // id: products[index].id,
//                   // imgUrl: products[index].imageUrl,
//                   // title: products[index].title,
//                   ),
//             ));
//   }
// }

class ProductsListView extends StatelessWidget {
  const ProductsListView({super.key, required this.showFav});
  final bool showFav;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFav ? productsData.favouritItems : productsData.item;
    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: products[index],
              //create: (context) => products[index],
              child: const ProductItemCard(
                  // id: products[index].id,
                  // imgUrl: products[index].imageUrl,
                  // title: products[index].title,
                  ),
            ));
  }
}
