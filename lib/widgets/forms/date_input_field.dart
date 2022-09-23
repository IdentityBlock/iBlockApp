import 'package:flutter/material.dart';

import 'package:date_field/date_field.dart';

class DateInputField extends StatefulWidget {
  final String label;
  TextEditingController controller = TextEditingController();
  EdgeInsets padding ;

  DateInputField(this.label, {
    Key? key,
    TextEditingController? controller,
    this.padding = const EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30)
  }) : super(key: key);

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: DateTimeFormField(
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
          suffixIcon: const Icon(Icons.event_note),
        ),
        mode: DateTimeFieldPickerMode.date,
        autovalidateMode: AutovalidateMode.always,
        onDateSelected: (DateTime value) {
          widget.controller.text = value.toString();
        },
      ),
    );
  }
}