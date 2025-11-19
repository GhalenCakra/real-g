import 'package:flutter/material.dart';
import 'package:real_g/screens/product_list.dart';
import 'package:real_g/screens/product_form.dart';
import 'package:real_g/screens/login.dart';
import 'package:real_g/screens/register.dart';
import 'package:real_g/screens/my_product_list.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();   // ⬅️ penting!

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Real G Menu",
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),

          // HOME
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),

          // ALL PRODUCTS
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text("All Products"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductListPage()),
              );
            },
          ),


          if (request.loggedIn)
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("My Products"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyProductListPage()),
                );
              },
            ),

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

          if (!request.loggedIn) ...[
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text("Login"),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),

            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text("Register"),
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
          ]

          else ...[
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {
                final response = await request.logout(
                  "http://localhost/auth/logout/",
                );

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logout berhasil")),
                );

                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ],
      ),
    );
  }
}
