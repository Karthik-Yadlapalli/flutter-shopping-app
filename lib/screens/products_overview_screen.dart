// ignore_for_file: depend_on_referenced_packages, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import 'package:shop_app/widgets/page_background.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid_view.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverview extends StatefulWidget {
  const ProductsOverview({super.key});
  static const routeName = '/';

  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant-O'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _showOnlyFavorites = !_showOnlyFavorites;
                });
              },
              icon: Icon(
                  _showOnlyFavorites ? Icons.favorite : Icons.favorite_border)),
          // PopupMenuButton(
          //     onSelected: (FilterOptions selectedValue) {
          //       setState(() {
          //         if (selectedValue == FilterOptions.Favorites) {
          //           _showOnlyFavorites = true;
          //         } else {
          //           _showOnlyFavorites = false;
          //         }
          //       });
          //     },
          //     child: Icon(
          //         _showOnlyFavorites ? Icons.favorite : Icons.favorite_border),
          //     itemBuilder: (_) => [
          //           const PopupMenuItem(
          //             value: FilterOptions.Favorites,
          //             child: Text('Only Favourits'),
          //           ),
          //           const PopupMenuItem(
          //             value: FilterOptions.All,
          //             child: Text('Show all'),
          //           ),
          //         ]),
          Consumer<Cart>(
            builder: (context, cartData, ch) =>
                BadgeB(value: cartData.itemCount.toString(), child: ch!),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Stack(
        children: [
          const PageBackground(),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ProductsListView(showFav: _showOnlyFavorites),
        ],
      ),
    );
  }
}
