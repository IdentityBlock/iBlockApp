import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const Button(this.label, {Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
        textStyle: const TextStyle(
          fontSize: 18,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      ),
      child: Text(label),
    );
  }
}