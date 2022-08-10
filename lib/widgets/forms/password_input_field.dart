import 'package:flutter/material.dart';

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Password',
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
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
    );
  }
}
