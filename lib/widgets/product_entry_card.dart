import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:real_g/models/product_entry.dart';

/// BASE URL AUTO-DETECT
String getBaseUrl() {
  if (kIsWeb) {
    return "http://127.0.0.1:8000";
  } else {
    return "http://10.0.2.2:8000"; // Android emulator
  }
}

class ProductEntryCard extends StatelessWidget {
  final ProductEntry product;
  final VoidCallback onTap;

  const ProductEntryCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        "${getBaseUrl()}/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 3,
          child: Row(
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
              ),
              const SizedBox(width: 16),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text("Rp ${product.price}"),
                    Text("Category: ${product.category}"),
                    if (product.isFeatured)
                      const Text(
                        "FEATURED ⭐",
                        style: TextStyle(color: Colors.amber),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
