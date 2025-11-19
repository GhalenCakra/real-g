import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:real_g/widgets/left_drawer.dart';
import 'package:validators/validators.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// ===================================================
// AUTO-DETECT BASE URL UNTUK WEB & ANDROID
// ===================================================
String getBaseUrl() {
  if (kIsWeb) {
    return "http://127.0.0.1:8000";   // Flutter Web (browser)
  } else {
    return "http://10.0.2.2:8000";    // Android Emulator
  }
}

// ===================================================
// FORM PAGE
// ===================================================
class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  // --- STATE ---
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
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tambah Produk Baru",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // NAMA PRODUK
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nama Produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (value) => _name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong!";
                  }
                  if (value.length < 3) {
                    return "Nama minimal 3 karakter!";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // HARGA
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Harga (Rp)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
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
                decoration: InputDecoration(
                  labelText: "Deskripsi Produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
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

              // THUMBNAIL URL
              TextFormField(
                decoration: InputDecoration(
                  labelText: "URL Thumbnail (opsional)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (value) => _thumbnail = value,
                validator: (value) {
                  if (value != null && value.isNotEmpty && !isURL(value)) {
                    return "URL tidak valid!";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // KATEGORI
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(
                  labelText: "Kategori",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                items: _categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                  _category = value!;
                }),
              ),

              const SizedBox(height: 16),

              // FEATURED SWITCH
              SwitchListTile(
                value: _isFeatured,
                title: const Text("isFeatured"),
                onChanged: (value) => setState(() {
                  _isFeatured = value;
                }),
              ),

              const SizedBox(height: 24),

              // TOMBOL SAVE
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {

                      final response = await request.post(
                        "${getBaseUrl()}/create-flutter/",
                        {
                          "title": _name,
                          "price": _price.toString(),
                          "description": _description,
                          "thumbnail": _thumbnail,
                          "category": _category,
                          "is_featured": _isFeatured.toString(),
                          "stock": "10",
                          "rating": "5",
                          "brand": "Adidas",
                        },
                      );

                      if (!mounted) return;

                      if (response["status"] == "success") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Produk berhasil ditambahkan!"),
                          ),
                        );

                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Gagal: ${response["message"] ?? "Unknown error"}",
                            ),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 32),
                  ),
                  child: const Text("Save", style: TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
