import 'package:flutter/material.dart';
import 'package:real_g/models/product_entry.dart';
import 'package:real_g/widgets/product_entry_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  Future<List<ProductEntry>> fetchProducts() async {
    final response = await http.get(
      Uri.parse("http://127.0.0.1:8000/products-json-all/"),
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
        title: const Text("All Products"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: fetchProducts(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!;

          if (products.isEmpty) {
            return const Center(child: Text("No products available."));
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
