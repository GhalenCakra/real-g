import 'package:flutter/material.dart';
import 'package:real_g/models/product_entry.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // THUMBNAIL
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: product.thumbnail.isNotEmpty
                  ? Image.network(
                      "http://127.0.0.1:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}",
                       height: 250,
                       width: double.infinity,
                       fit: BoxFit.cover,
                       errorBuilder: (_, __, ___) =>
                       const Icon(Icons.broken_image, size: 60),
                    )
                  : Container(
                      height: 250,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 60),
                    ),
            ),

            const SizedBox(height: 20),

            // TITLE
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // PRICE
            Text(
              "Rp ${product.price}",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // CATEGORY + BRAND
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    product.category.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Brand: ${product.brand}",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // RATING + VIEWS
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text(" ${product.rating}"),

                const SizedBox(width: 20),
                const Icon(Icons.visibility),
                Text(" ${product.views} views"),
              ],
            ),

            const SizedBox(height: 20),

            // FEATURED
            if (product.isFeatured)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "FEATURED",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // DESCRIPTION
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              product.description,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 20),

            // STOCK
            Text(
              "Stock: ${product.stock}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            // CREATED & UPDATED
            Text(
              "Created at: ${formatDate(product.createdAt)}",
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              "Updated at: ${formatDate(product.updatedAt)}",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            // BACK BUTTON
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Back"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
