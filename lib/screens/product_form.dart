import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:real_g/widgets/left_drawer.dart';
import 'package:validators/validators.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

String getBaseUrl() {
  if (kIsWeb) {
    return "http://127.0.0.1:8000";
  } else {
    return "http://10.0.2.2:8000";
  }
}

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  double _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "Shoes";
  bool _isFeatured = false;

  final List<String> _categories = [
    "Shoes",
    "Jersey",
    "Accessories",
    "Training",
    "Lifestyle",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Produk Baru",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // NAMA PRODUK
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nama Produk",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // HARGA
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Harga (Rp)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    _price = double.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harga tidak boleh kosong!";
                  }
                  if (double.tryParse(value) == null) {
                    return "Harga harus berupa angka!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // DESKRIPSI
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Deskripsi Produk",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _description = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // THUMBNAIL
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "URL Thumbnail (Opsional)",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _thumbnail = value,
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      !isURL(value)) {
                    return "URL tidak valid!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // KATEGORI
              DropdownButtonFormField(
                value: _category,
                items: _categories
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v!),
                decoration: const InputDecoration(
                  labelText: "Kategori",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // FEATURED SWITCH
              SwitchListTile(
                title: const Text("Featured"),
                value: _isFeatured,
                onChanged: (v) => setState(() => _isFeatured = v),
              ),
              const SizedBox(height: 24),

              // ====== SAVE BUTTON ======
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final request = context.read<CookieRequest>();

                  final response = await request.postJson(
                    "${getBaseUrl()}/create-flutter/",
                    jsonEncode({
                      "title": _name,
                      "price": _price,
                      "description": _description,
                      "thumbnail": _thumbnail,
                      "category": _category,
                      "is_featured": _isFeatured,
                      "stock": 10,
                      "rating": 5,
                      "brand": "Adidas",
                    }),
                  );

                  if (!mounted) return;

                  if (response["status"] == "success") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text("Produk berhasil ditambahkan!")),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Gagal: ${response['message'] ?? 'Unknown error'}"),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 32),
                ),
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
