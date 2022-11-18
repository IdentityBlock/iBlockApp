import 'package:flutter/material.dart';
import 'package:iblock/widgets/forms/text_input_field.dart';

class EditDialog extends StatefulWidget {
  final String property;
  Function onSubmit;
  EditDialog(this.property, this.onSubmit,{Key? key}) : super(key: key);

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  TextEditingController valueText =TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInputField("New ${widget.property}", padding: const EdgeInsets.all(8), controller: valueText),
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
            widget.onSubmit(valueText.text.trim());
            Navigator.pop(context);
          },
          child: const Text('Edit'),
        ),
      ],
    );
  }
}
