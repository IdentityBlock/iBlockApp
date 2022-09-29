import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class DateInputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  EdgeInsets padding;

  DateInputField(this.label,
      {Key? key,
      required this.controller,
      this.padding =
          const EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30)})
      : super(key: key);

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
            suffixIcon: const Icon(Icons.event_note),
            fillColor: Theme.of(context).colorScheme.secondary),
        mode: DateTimeFieldPickerMode.date,
        autovalidateMode: AutovalidateMode.always,
        onDateSelected: (DateTime value) {
          widget.controller.text = value.toString().replaceFirst("00:00:00.000", "");
        },
      ),
    );
  }
}
