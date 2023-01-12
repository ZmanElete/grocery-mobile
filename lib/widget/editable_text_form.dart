import 'dart:developer';

import 'package:flutter/material.dart';

class EditableController {
  final ValueNotifier<bool> editable = ValueNotifier(false);
  final bool Function()? validate;
  final ValueNotifier<Object?> currentEditableField = ValueNotifier<Object?>(null);

  EditableController({required bool editable, this.validate}) {
    this.editable.value = editable;
  }

  static EditableController? of(BuildContext context) {
    return _EditableFormState.of(context)?.widget.controller;
  }

  void edit(Object object) {
    currentEditableField.value ??= object;
  }

  void stopEditing(Object object) {
    if(currentEditableField.value == object) {
      currentEditableField.value = null;
    }
  }
}

class EditableForm extends StatefulWidget {
  final Widget Function(BuildContext) builder;
  final EditableController controller;

  const EditableForm({
    required this.builder,
    required this.controller,
    super.key,
  });

  @override
  State<EditableForm> createState() => _EditableFormState();

}

class _EditableFormState extends State<EditableForm> {
  static _EditableFormState? of(BuildContext context) =>
      context.findAncestorStateOfType<_EditableFormState>();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller.editable,
      builder: (context, editable, _) {
        log('editable: $editable', level: 1);
        return widget.builder.call(context);
      },
    );
  }
}
