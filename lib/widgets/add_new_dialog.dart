import 'package:flutter/material.dart';

class AddNewDialog extends StatelessWidget {
  const AddNewDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
title: const Text('Add New'),
      content: const Text('Add new item'),
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
