import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => _username = v,
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Username wajib diisi" : null,
            ),

            const SizedBox(height: 12),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (v) => _password = v,
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Password wajib diisi" : null,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;

                final response = await request.login(
                  "http://127.0.0.1:8000/auth/login/",
                  {
                    "username": _username,
                    "password": _password,
                  },
                );

                if (!mounted) return;

                // CEK LOGIN YANG BENAR:
                if (request.loggedIn) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Login berhasil, selamat datang $_username")),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MyHomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response["message"])),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
