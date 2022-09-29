import 'package:flutter/material.dart';

class SelectInputField extends StatefulWidget {
  final String label;
  final List<String> options;
  final TextEditingController controller;
  EdgeInsets padding;

  SelectInputField(this.label, this.options,
      { Key? key,
        required this.controller,
        this.padding =
          const EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30)})
      : super(key: key);

  @override
  State<SelectInputField> createState() => _SelectInputFieldState();
}

class _SelectInputFieldState extends State<SelectInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColorDark,
                width: 1,
              ),
            ),
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
            fillColor: Theme.of(context).primaryColorLight),
        style: Theme.of(context).textTheme.bodyMedium,
        items: widget.options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          widget.controller.text = value!;
        },
      ),
    );
  }
}
