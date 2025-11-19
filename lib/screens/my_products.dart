import 'package:flutter/material.dart';
import 'package:real_g/models/product_entry.dart';
import 'package:real_g/widgets/product_entry_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  Future<List<ProductEntry>> fetchMyProducts() async {
    final response = await http.get(
      Uri.parse("http://127.0.0.1:8000/products-json-user/"),
    );

    List<ProductEntry> list = [];

    for (var p in jsonDecode(response.body)) {
      list.add(ProductEntry.fromJson(p));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Products"),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: fetchMyProducts(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!;

          if (products.isEmpty) {
            return const Center(child: Text("You have no products."));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, i) {
              return ProductEntryCard(
                product: products[i],
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
