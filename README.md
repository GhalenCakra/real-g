# real_g

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Real G
# Tugas 7
# 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
Widget tree pada Flutter adalah struktur hirarkis yang menggambarkan bagaimana setiap widget saling berhubungan dan tersusun di layar. Setiap widget dapat memiliki widget lain di dalamnya, dan hubungan ini disebut sebagai hubungan parent-child (induk-anak). Widget parent bertanggung jawab mengatur tata letak dan perilaku dari widget child yang berada di dalamnya. Seluruh tampilan di layar sebenarnya merupakan hasil dari widget-widget yang saling bertumpuk membentuk sebuah pohon widget.

# 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
 - MaterialApp: sebagai pintu masuk utama  aplikasi, menyediakan struktur dan tema berbasis Material Design.

 - Scaffold: menyediakan struktur dasar halaman seperti AppBar dan body.

 - AppBar: menampilkan bagian header aplikasi.

 - Text: digunakan untuk menampilkan teks seperti judul dan informasi pengguna.

 - Row dan Column: untuk mengatur tata letak widget secara horizontal dan vertikal.

 - Card: untuk menampilkan informasi NPM, nama, dan kelas dalam komponen berbentuk kartu.

 - GridView: menampilkan tombol menu dalam bentuk grid.

 - Container: mengatur ukuran, padding, dan dekorasi widget.

 - Icon: menampilkan ikon pada tombol.

 - SnackBar: sebagai notifikasi singkat ketika tombol ditekan.

 - Material dan InkWell: memberikan efek klik pada tombol menu.

 - Widget MaterialApp memiliki peran yang sangat penting karena widget ini bertugas

 # 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
 Widget MaterialApp bertugas menginisialisasi tema, navigasi, dan konfigurasi utama aplikasi. Oleh karena itu, MaterialApp ditempatkan sebagai widget root, sehingga seluruh widget lainnya berada dalam konteks aplikasi yang konsisten secara visual dan fungsional.

 # 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
 StatelessWidget digunakan ketika tampilan tidak membutuhkan perubahan data saat aplikasi berjalan, contohnya halaman menu yang hanya menampilkan tombol statis.
Sebaliknya, StatefulWidget digunakan ketika data atau tampilan perlu diperbarui secara dinamis, misalnya pada fitur yang menambahkan produk baru ke dalam daftar produk. Saya memilih StatelessWidget ketika konten bersifat tetap dan tidak ada interaksi yang mengubah state, sedangkan StatefulWidget saya pilih ketika ada perubahan kondisi aplikasi.

# 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
BuildContext menyediakan informasi posisi widget dalam widget tree dan memungkinkan akses ke fitur penting seperti tema, ukuran layar, dan navigasi. Melalui BuildContext, saya dapat memanggil SnackBar dan mengatur elemen UI berdasarkan parent widget-nya.

# 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
Fitur hot reload untuk mempercepat proses debugging dan penyesuaian UI. Hot reload mempertahankan state aplikasi dan hanya memperbarui bagian tampilan yang berubah, sehingga sangat efisien ketika mengatur tampilan. Sedangkan hot restart digunakan ketika perubahan membutuhkan inisialisasi ulang seluruh aplikasi, termasuk state yang tersimpan. Perbedaannya utama adalah hot reload mempertahankan state, sementara hot restart mengulang kembali aplikasi dari awal.