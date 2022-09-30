import 'package:flutter/material.dart';
import 'package:iblock/widgets/forms/text_input_field.dart';

class AddNewDialog extends StatefulWidget {
  Function onSubmit;
  AddNewDialog(this.onSubmit,{Key? key}) : super(key: key);

  @override
  State<AddNewDialog> createState() => _AddNewDialogState();
}

class _AddNewDialogState extends State<AddNewDialog> {
  TextEditingController propertyText = TextEditingController();
  TextEditingController valueText =TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Entry'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInputField("Property Name", padding: const EdgeInsets.all(8), controller: propertyText),
          TextInputField("Property Value", padding: const EdgeInsets.all(8), controller: valueText),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onSubmit(propertyText.text, valueText.text);
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
