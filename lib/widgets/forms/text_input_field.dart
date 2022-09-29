import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  EdgeInsets padding ;

  TextInputField(this.label, {
    Key? key,
    required this.controller,
    this.padding = const EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30)
  }) : super(key: key);

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColorDark,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 1,
            ),
          ),
          fillColor: Theme.of(context).primaryColorLight
        ),
        style: Theme.of(context).textTheme.bodyMedium
      ),
    );
  }
}
