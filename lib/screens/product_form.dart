import 'package:flutter/material.dart';
import 'package:real_g/widgets/left_drawer.dart';
import 'package:validators/validators.dart'; 

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  // --- State input ---
  String _name = "";
  double _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "Shoes";
  bool _isFeatured = false;

  // --- Daftar kategori ---
  final List<String> _categories = [
    'Shoes',
    'Jersey',
    'Accessories',
    'Training',
    'Lifestyle'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Produk Baru"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Nama Produk ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nama Produk",
                  hintText: "Masukkan nama produk (min. 3 karakter)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (val) => setState(() => _name = val),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Nama tidak boleh kosong!";
                  }
                  if (val.length < 3) {
                    return "Nama minimal 3 karakter!";
                  }
                  if (val.length > 50) {
                    return "Nama terlalu panjang (maksimal 50 karakter)!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Harga Produk ===
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Harga Produk (Rp)",
                  hintText: "Contoh: 250000",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (val) =>
                    setState(() => _price = double.tryParse(val) ?? 0),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Harga tidak boleh kosong!";
                  }
                  final parsed = double.tryParse(val);
                  if (parsed == null) {
                    return "Harga harus berupa angka!";
                  }
                  if (parsed <= 0) {
                    return "Harga tidak boleh negatif atau nol!";
                  }
                  if (parsed > 1000000000) {
                    return "Harga tidak boleh lebih dari 1 miliar!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Deskripsi Produk ===
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Deskripsi Produk",
                  hintText: "Tuliskan detail produk (min. 10 karakter)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (val) => setState(() => _description = val),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  if (val.length < 10) {
                    return "Deskripsi terlalu pendek!";
                  }
                  if (val.length > 300) {
                    return "Deskripsi terlalu panjang (maksimal 300 karakter)!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Thumbnail Produk ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "URL Thumbnail (opsional)",
                  hintText: "https://contoh.com/gambar.jpg",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (val) => setState(() => _thumbnail = val),
                validator: (val) {
                  if (val != null && val.isNotEmpty && !isURL(val)) {
                    return "Masukkan URL valid (awali dengan http/https)!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Kategori Produk ===
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(
                  labelText: "Kategori",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                items: _categories
                    .map((cat) =>
                        DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (newVal) => setState(() => _category = newVal!),
              ),
              const SizedBox(height: 16),

              // === Produk Unggulan ===
              SwitchListTile(
                title: const Text("isFeatured"),
                value: _isFeatured,
                onChanged: (val) => setState(() => _isFeatured = val),
              ),

              const SizedBox(height: 24),

              // === Tombol Simpan ===
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 32),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Produk berhasil disimpan!"),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Nama: $_name"),
                                Text("Harga: Rp $_price"),
                                Text("Deskripsi: $_description"),
                                if (_thumbnail.isNotEmpty)
                                  Text("Thumbnail: $_thumbnail"),
                                Text("Kategori: $_category"),
                                Text("Unggulan: ${_isFeatured ? 'Ya' : 'Tidak'}"),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _formKey.currentState!.reset();
                                setState(() {
                                  _isFeatured = false;
                                  _category = "Shoes";
                                });
                              },
                              child: const Text("OK"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
