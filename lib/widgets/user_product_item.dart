// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem(
      {super.key, required this.imgUrl, required this.title, required this.id});
  final String title;
  final String imgUrl;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imgUrl)),
      trailing: SizedBox(
        width: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(EditProduct.routeName, arguments: id);
                },
                child: const Icon(Icons.edit)),
            InkWell(
              onTap: () {
                Provider.of<Products>(context, listen: false).deleteProduct(id);
              },
              child: const Icon(
                Icons.delete,
                color: Color.fromARGB(255, 231, 83, 72),
              ),
            )
          ],
        ),
      ),
    );
  }
}
