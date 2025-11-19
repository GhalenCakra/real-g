import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:real_g/models/product_entry.dart';
import 'package:real_g/widgets/product_entry_card.dart';
import 'package:real_g/screens/product_detail.dart';

/// ===============================
/// BASE URL AUTO DETECT PLATFORM
/// ===============================
String getBaseUrl() {
  if (kIsWeb) {
    return "http://127.0.0.1:8000";
  } else {
    return "http://10.0.2.2:8000"; // emulator Android
  }
}

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  Future<List<ProductEntry>> fetchProducts() async {
    final url = Uri.parse("${getBaseUrl()}/json/");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to load products");
    }

    List jsonData = jsonDecode(response.body);
    return jsonData.map((p) => ProductEntry.fromJson(p)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: FutureBuilder<List<ProductEntry>>(
        future: fetchProducts(),
        builder: (_, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Failed to load products.\n${snapshot.error}",
                textAlign: TextAlign.center,
              ),
            );
          }

          final products = snapshot.data ?? [];

          // Empty
          if (products.isEmpty) {
            return const Center(child: Text("No products available."));
          }

          // List
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, i) {
              return ProductEntryCard(
                product: products[i],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailPage(product: products[i]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
