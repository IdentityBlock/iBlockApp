import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  final String label;
  TextEditingController controller = TextEditingController();
  EdgeInsets padding ;

  TextInputField(this.label, {
    Key? key,
    TextEditingController? controller,
    this.padding = const EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30)
  }) : super(key: key);

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
      child: TextFormField(
        controller: widget.controller,
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
      ),
    );
  }
}
