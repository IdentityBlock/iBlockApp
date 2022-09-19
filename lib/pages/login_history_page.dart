import 'package:flutter/material.dart';

class LoginHistoryPage extends StatelessWidget {
  const LoginHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login History'),
      ),
      body: const Center(child: Text("Login History"),),
    );
  }
}
