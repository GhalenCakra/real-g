import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

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

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  Future<List<ProductEntry>> fetchMyProducts(CookieRequest request) async {
    final response = await request.get("${getBaseUrl()}/json/user/");

    List<ProductEntry> list = [];
    for (var p in response) {
      list.add(ProductEntry.fromJson(p));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Products"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: FutureBuilder(
        future: fetchMyProducts(request),
        builder: (_, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Failed to load your products.\n${snapshot.error}",
                textAlign: TextAlign.center,
              ),
            );
          }

          final products = snapshot.data ?? [];

          // Empty list
          if (products.isEmpty) {
            return const Center(
              child: Text("You have no products."),
            );
          }

          // Success → show list
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, i) {
              return ProductEntryCard(
                product: products[i],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductDetailPage(product: products[i]),
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
