import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          onPressed: () => GoRouter.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red
          ),
          onPressed: () => GoRouter.of(context).pop(true),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
