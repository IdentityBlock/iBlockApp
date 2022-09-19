import 'package:flutter/material.dart';
import 'package:iblock/widgets/forms/text_input_field.dart';

class AddNewDialog extends StatelessWidget {
  const AddNewDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Entry'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInputField("Property Name", padding: const EdgeInsets.all(8),),
          TextInputField("Property Value", padding: const EdgeInsets.all(8),),
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
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
