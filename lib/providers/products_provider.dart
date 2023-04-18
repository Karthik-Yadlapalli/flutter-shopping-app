// ignore_for_file: prefer_final_fields, unused_field

import 'dart:convert';
import 'package:flutter/material.dart';
import 'products.dart';
import 'package:http/http.dart' as http;

class Products extends ChangeNotifier {
  final List<Product> _items = [
    Product(
        id: "001",
        title: "Ficus Bonsai Plant",
        dimensions:
            'We ship in a standard 10x10x60 cm containers for easy handling and safety of your products. The products are slightly bent at the bottom for perfect hold.',
        material:
            'These artificial flowers are made with real-touch plastic for exellent touch and feel.',
        shipping_return_details:
            'We offer same day shipping and 30 days return or exchange. Don\'t like the product you received? Get in touch with our team at +91 886652xxxx on Phone or Whatsapp.',
        description:
            "Artificial Ficus Bonsai Plant in a Ceramic Vase, Table/Desk Plant (6 Stems, 252 Leafs, 41 cm Tall, Mixed Material, Green)",
        price: 19.99,
        careInstruction:
            'We believe in sustainable shopping experience. These plants are durable , and can easily withstand indoor weather conditions. Our plants and flowers are washable and pet-friendly too.',
        imageUrl:
            "https://media.istockphoto.com/id/1171494620/photo/bright-living-room-with-large-houseplant-on-wooden-floor-popular-house-plant.jpg?s=612x612&w=0&k=20&c=t8bELXss92Z5z5jxFpgJe_uacwCLDG62A_UppMQ3hUw="),
    Product(
        id: "004",
        title: "Bamboo Bonsai",
        dimensions:
            'We ship in a standard 10x10x60 cm containers for easy handling and safety of your products. The products are slightly bent at the bottom for perfect hold.',
        material:
            'These artificial flowers are made with real-touch plastic for exellent touch and feel.',
        shipping_return_details:
            'We offer same day shipping and 30 days return or exchange. Don\'t like the product you received? Get in touch with our team at +91 886652xxxx on Phone or Whatsapp.',
        careInstruction:
            'We believe in sustainable shopping experience. These plants are durable , and can easily withstand indoor weather conditions. Our plants and flowers are washable and pet-friendly too.',
        description:
            "Artificial Bamboo Bonsai Plant with Ceramic Pot, Table/Desk Plant (199 Leafs, 38 cm Tall, Mixed Material, Green)",
        price: 24.99,
        imageUrl:
            "https://cdn.shopify.com/s/files/1/0403/2465/products/unnamed_1024x1024.jpg?v=1588659102"),
    Product(
        id: "007",
        title: "Bonsai Fiddle Leaf Plant",
        dimensions:
            'We ship in a standard 10x10x60 cm containers for easy handling and safety of your products. The products are slightly bent at the bottom for perfect hold.',
        material:
            'These artificial flowers are made with real-touch plastic for exellent touch and feel.',
        shipping_return_details:
            'We offer same day shipping and 30 days return or exchange. Don\'t like the product you received? Get in touch with our team at +91 886652xxxx on Phone or Whatsapp.',
        careInstruction:
            'We believe in sustainable shopping experience. These plants are durable , and can easily withstand indoor weather conditions. Our plants and flowers are washable and pet-friendly too.',
        description:
            "Artificial Bonsai Fiddle Leaf Plant with Ceramic Pot (29 cm, Green)",
        price: 29.99,
        imageUrl:
            "https://cdn.shopify.com/s/files/1/0248/6983/products/ElhoVibeBlue_Monstera.jpg?v=1676332912"),
    Product(
        id: "012",
        title: "Artificial Plant Bonsai",
        dimensions:
            'We ship in a standard 10x10x60 cm containers for easy handling and safety of your products. The products are slightly bent at the bottom for perfect hold.',
        material:
            'These artificial flowers are made with real-touch plastic for exellent touch and feel.',
        shipping_return_details:
            'We offer same day shipping and 30 days return or exchange. Don\'t like the product you received? Get in touch with our team at +91 886652xxxx on Phone or Whatsapp.',
        careInstruction:
            'We believe in sustainable shopping experience. These plants are durable , and can easily withstand indoor weather conditions. Our plants and flowers are washable and pet-friendly too.',
        description:
            "Artificial Plant Bonsai in Grey Plastic Pot for Home Decor | Decoration Items for Living Room | Decorative Table Top Indoor Plants Bonsai for Office Desks & Counters (Banyan Bonsai)",
        price: 34.99,
        imageUrl:
            "https://cdn.shopify.com/s/files/1/0697/4819/5626/products/815LBKcNpCL._SL1500.jpg?v=1675803554&width=493"),
    Product(
        id: "015",
        dimensions:
            'We ship in a standard 10x10x60 cm containers for easy handling and safety of your products. The products are slightly bent at the bottom for perfect hold.',
        material:
            'These artificial flowers are made with real-touch plastic for exellent touch and feel.',
        title: "Large Floor Areca Palm Plant",
        careInstruction:
            'We believe in sustainable shopping experience. These plants are durable , and can easily withstand indoor weather conditions. Our plants and flowers are washable and pet-friendly too.',
        description:
            "Artificial Large Floor Areca Palm Plant with/without Plastic Pot for Home Decor | Decoration Items for Living Room | Decorative Table-top Indoor Plants Bonsai for Office Desks & Counters",
        price: 39.99,
        shipping_return_details:
            'We offer same day shipping and 30 days return or exchange. Don\'t like the product you received? Get in touch with our team at +91 886652xxxx on Phone or Whatsapp.',
        imageUrl:
            "https://cdn.shopify.com/s/files/1/0697/4819/5626/products/81jR5UU9y3L._SL1500.jpg?v=1672467599&width=493"),
    Product(
        id: "018",
        title: "Artificial Bamboo Big Size Plant",
        dimensions:
            'We ship in a standard 10x10x60 cm containers for easy handling and safety of your products. The products are slightly bent at the bottom for perfect hold.',
        material:
            'These artificial flowers are made with real-touch plastic for exellent touch and feel.',
        shipping_return_details:
            'We offer same day shipping and 30 days return or exchange. Don\'t like the product you received? Get in touch with our team at +91 886652xxxx on Phone or Whatsapp.',
        careInstruction:
            'We believe in sustainable shopping experience. These plants are durable , and can easily withstand indoor weather conditions. Our plants and flowers are washable and pet-friendly too.',
        description:
            "Artificial Bamboo Big Size Plant with Plastic Pot (Height - 5 Feet) (With / Without Pot)",
        price: 14.99,
        imageUrl:
            "https://cdn.shopify.com/s/files/1/0697/4819/5626/products/81pnZz3BUrL._SL1500.jpg?v=1672468318&width=493"),
    Product(
        id: "020",
        title: "Artificial Daisy Flower Bunch",
        dimensions:
            'We ship in a standard 10x10x60 cm containers for easy handling and safety of your products. The products are slightly bent at the bottom for perfect hold.',
        material:
            'These artificial flowers are made with real-touch plastic for exellent touch and feel.',
        shipping_return_details:
            'We offer same day shipping and 30 days return or exchange. Don\'t like the product you received? Get in touch with our team at +91 886652xxxx on Phone or Whatsapp.',
        careInstruction:
            'We believe in sustainable shopping experience. These plants are durable , and can easily withstand indoor weather conditions. Our plants and flowers are washable and pet-friendly too.',
        description:
            "Artificial Daisy Flower Bunch in Grey Pot for Home Decoration (Height: 17 inches) | Faux Potted Flower Bouquets | Decoration Items for Living Room (Daisy Bush in Pot)",
        price: 34.99,
        imageUrl:
            "https://cdn.shopify.com/s/files/1/0697/4819/5626/products/B0-AVG9-XQM6_2.jpg?v=1673963513&width=493"),
    Product(
        id: "028",
        dimensions:
            'We ship in a standard 10x10x60 cm containers for easy handling and safety of your products. The products are slightly bent at the bottom for perfect hold.',
        material:
            'These artificial flowers are made with real-touch plastic for exellent touch and feel.',
        description:
            "Artificial Butterfly Orchid Flower Sticks for Home Decoration | Faux Flowers for Vases | Decoration Items for living room | 42 inches",
        title: "Artificial Butterfly Orchid Flower Sticks",
        shipping_return_details:
            'We offer same day shipping and 30 days return or exchange. Don\'t like the product you received? Get in touch with our team at +91 886652xxxx on Phone or Whatsapp.',
        careInstruction:
            'We believe in sustainable shopping experience. These plants are durable , and can easily withstand indoor weather conditions. Our plants and flowers are washable and pet-friendly too.',
        imageUrl:
            "https://cdn.shopify.com/s/files/1/0697/4819/5626/products/81CRoFi2DpL._SL1500.jpg?v=1672468824&width=493",
        price: 93.22)
  ];

  var _favoritesOnly = false;

  List<Product> get item {
    return [..._items];
  }

  List<Product> get favouritItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  Product findById(String id) {
    return item.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    final url =
        Uri.https('shop-910e1-default-rtdb.firebaseio.com' + '/products.json');
    try {
      final response = await http.get(url);
      final extractedProducts =
          json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];
      extractedProducts.forEach((prodId, prodData) {
        loadedProduct.add(Product(
            dimensions: prodData['dimensions'],
            shipping_return_details: prodData['shipping_return_details'],
            material: prodData['material'],
            careInstruction: prodData['careInstruction'],
            id: prodId,
            description: prodData['description'],
            title: prodData['title'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price']));
      });
      print(json.decode(response.body));
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        Uri.https('shop-910e1-default-rtdb.firebaseio.com' + '/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'descreption': product.description,
          'price': product.price,
          'shipping': product.shipping_return_details,
          'material': product.material,
          'dimensions': product.dimensions,
          'imgUrl': product.imageUrl,
          'care': product.careInstruction,
          'isFav': product.isFavourite
        }),
      );


      var newProduct = Product(
          dimensions: product.dimensions,
          shipping_return_details: product.shipping_return_details,
          material: product.material,
          careInstruction: product.careInstruction,
          id: json.decode(response.body)['name'],
          description: product.description,
          title: product.title,
          imageUrl: product.imageUrl,
          price: product.price);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void deleteProduct(String id) {
    final url = Uri.https(
        'shop-910e1-default-rtdb.firebaseio.com' + '/products/$id.json');
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    Product? existingProduct = _items[existingProductIndex];
    http.delete(url).then((response) {
      print(response.statusCode);
      existingProduct = null;
    }).catchError((e) {
      _items.insert(existingProductIndex, existingProduct!);
    });
    _items.remove(existingProductIndex);
    notifyListeners();
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url = Uri.https(
          'shop-910e1-default-rtdb.firebaseio.com' + '/products/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'descreption': newProduct.description,
            'dimensions': newProduct.dimensions,
            'shipping_return_details': newProduct.shipping_return_details,
            'careInstruction': newProduct.careInstruction,
            'material': newProduct.material,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
