import 'package:flutter/material.dart';

class SelectInputField extends StatefulWidget {
  final String label;
  final List<String> options;
  final TextEditingController controller = TextEditingController();
  EdgeInsets padding;

  SelectInputField(this.label, this.options,
      { Key? key,
        TextEditingController? controller,
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
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1,
            ),
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
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
