import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 230,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      child: Column(children: [
        Container(
          height: 300,
        ),
        const Divider(),
        Container(
          decoration: const BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
            title: const Text('Shop'),
            leading: const Icon(Icons.shopping_bag),
          ),
        ),
        const Divider(),
        Container(
          decoration: const BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/orders');
            },
            title: const Text('Orders'),
            leading: const Icon(Icons.payment),
          ),
        ),
        const Divider(),
        Container(
          decoration: const BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/user_product');
            },
            title: const Text(
              'Manage',
              style: TextStyle(fontSize: 14),
            ),
            leading: const Icon(Icons.edit),
          ),
        ),
      ]),
    );
  }
}
