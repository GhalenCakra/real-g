import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Screens
import 'package:real_g/menu.dart';
import 'package:real_g/screens/all_products.dart';
import 'package:real_g/screens/my_products.dart';
import 'package:real_g/screens/product_form.dart';
import 'package:real_g/screens/login.dart';
import 'package:real_g/screens/register.dart';

/// Auto detect base URL (Web vs Android Emulator)
String getBaseUrl() {
  // Flutter WEB -> localhost
  // Android Emulator -> 10.0.2.2
  if (kIsWeb) {
    return "http://127.0.0.1:8000";
  } else {
    return "http://10.0.2.2:8000";
  }
}

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>(); // IMPORTANT

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.pink),
            child: Text(
              "Real G Menu",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),

          // =====================
          // HOME
          // =====================
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MyHomePage()),
              );
            },
          ),

          // =====================
          // ALL PRODUCTS
          // =====================
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text("All Products"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AllProductsPage()),
              );
            },
          ),

          // =====================
          // MY PRODUCTS — Only if logged in
          // =====================
          if (request.loggedIn)
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("My Products"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyProductsPage()),
                );
              },
            ),

          // =====================
          // CREATE PRODUCT — Only if logged in
          // =====================
          if (request.loggedIn)
            ListTile(
              leading: const Icon(Icons.add_box),
              title: const Text("Create Product"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductFormPage()),
                );
              },
            ),

          const Divider(),

          // =====================
          // LOGIN & REGISTER (only when NOT logged in)
          // =====================
          if (!request.loggedIn) ...[
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text("Login"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text("Register"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              },
            ),
          ]

          // =====================
          // LOGOUT (only when LOGGED IN)
          // =====================
          else ...[
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {
                final response = await request.logout(
                  "${getBaseUrl()}/auth/logout/",
                );

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logout berhasil.")),
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
