import 'package:flutter/material.dart';

class PasswordInputField extends StatelessWidget {
  final String label;
  const PasswordInputField(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          fillColor: Theme.of(context).primaryColorLight),
      style: Theme.of(context).textTheme.bodyMedium,
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
    );
  }
}
