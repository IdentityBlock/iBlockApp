import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  Button(this.label, {Key? key, required this.onPressed, this.color=Colors.blue, this.textColor=Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: color,
        textStyle: const TextStyle(
          fontSize: 18,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      ),
      child: Text(label),
    );
  }
}