import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String targetTitle;

  const ConfirmDeleteDialog({required this.targetTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('Are you sure you want to delete $targetTitle?'),
      actionsOverflowButtonSpacing: 20,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
