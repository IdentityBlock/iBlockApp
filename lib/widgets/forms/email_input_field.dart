import 'package:flutter/material.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }
}
