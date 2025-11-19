import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String _username = "";
  String _password1 = "";
  String _password2 = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => _username = v,
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Username tidak boleh kosong" : null,
            ),

            const SizedBox(height: 12),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (v) => _password1 = v,
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Password tidak boleh kosong" : null,
            ),

            const SizedBox(height: 12),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (v) => _password2 = v,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Konfirmasi password wajib";
                }
                if (v != _password1) {
                  return "Password tidak sama";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;

                final response = await request.postJson(
                  "http://127.0.0.1:8000/auth/register/",
                  {
                    "username": _username,
                    "password1": _password1,
                    "password2": _password2,
                  },
                );

                if (!mounted) return;

                if (response["status"] == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Register berhasil")),
                  );

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response["message"])),
                  );
                }
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
