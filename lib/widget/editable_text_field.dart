import 'package:flutter/material.dart';
import 'package:grocery_genie/widget/editable_text_form.dart';

enum EditableTextBehavior {
  clearOnConfirm,
}

class EditableTextField extends StatefulWidget {
  final String? initialText;
  final Function(String) onValueConfirmed;
  final TextStyle? style;
  final String? hint;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final double? iconSize;
  final VoidCallback? onEditPressedOverride;
  final int? minLines;
  final List<EditableTextBehavior> behaviors;

  const EditableTextField({
    required this.onValueConfirmed,
    this.prefixIcon,
    this.keyboardType,
    this.style,
    this.initialText,
    this.hint,
    this.iconSize,
    this.onEditPressedOverride,
    this.minLines,
    this.behaviors = const [],
    super.key,
  });

  @override
  State<EditableTextField> createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  late final TextEditingController textEditingController;
  late String currentValue;

  bool get editing {
    if (controller != null) {
      return controller!.currentEditableField.value == this;
    } else {
      return _editing;
    }
  }

  bool get editable => controller?.editable.value ?? true;

  bool _editing = false;
  EditableController? controller;

  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.initialText);
    currentValue = widget.initialText ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller = EditableController.of(context);
    if (controller != null) {
      return ValueListenableBuilder(
        valueListenable: controller!.currentEditableField,
        builder: (context, __, ___) => _build(context),
      );
    }
    return _build(context);
  }

  Widget _build(BuildContext context) {
    final theme = Theme.of(context);
    return IconTheme(
      data: theme.iconTheme.copyWith(
        size: widget.iconSize,
      ),
      child: editable && editing //
          ? _editingField(context)
          : _notEditingField(context),
    );
  }

  double get iconButtonSplashRadius => (widget.iconSize ?? 24) * .75;

  Widget _editingField(BuildContext context) {
    final theme = Theme.of(context);

    Widget? prefixIcon = widget.prefixIcon;
    if (prefixIcon != null && widget.iconSize != null) {
      prefixIcon = IconTheme(
        data: theme.iconTheme.copyWith(
          size: widget.iconSize,
        ),
        child: prefixIcon,
      );
    }

    return TextField(
      controller: textEditingController,
      autofocus: true,
      style: widget.style,
      keyboardType: widget.keyboardType,
      minLines: widget.minLines,
      maxLines: widget.minLines != null ? 10000 : null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        hintText: widget.hint,
        prefixIcon: prefixIcon,
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: _confirmInput,
              splashRadius: iconButtonSplashRadius,
              iconSize: widget.iconSize,
              icon: const Icon(Icons.check),
            ),
            IconButton(
              onPressed: () {
                textEditingController.text = currentValue;
                if (widget.behaviors.contains(EditableTextBehavior.clearOnConfirm)) {
                  textEditingController.text = '';
                }
                _stopEditing();
              },
              splashRadius: iconButtonSplashRadius,
              iconSize: widget.iconSize,
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmInput() {
    widget.onValueConfirmed(textEditingController.text);
    if (widget.behaviors.contains(EditableTextBehavior.clearOnConfirm)) {
      textEditingController.text = '';
    }
    currentValue = textEditingController.text;
    _stopEditing();
  }

  Widget _notEditingField(BuildContext context) {
    final theme = Theme.of(context);
    String textToShow = currentValue;
    TextStyle style = widget.style ?? DefaultTextStyle.of(context).style;
    if (textToShow == '' && widget.hint != null) {
      textToShow = widget.hint!;
      style = style.copyWith(
        color: style.color?.withOpacity(.8),
        fontWeight: FontWeight.w300,
      );
    }

    var padding = theme.inputDecorationTheme.contentPadding ?? EdgeInsets.zero;
    if (widget.prefixIcon != null) {
      padding = EdgeInsets.zero;
    }

    return Padding(
      padding: padding,
      child: Row(
        children: [
          if (widget.prefixIcon != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: 24,
                height: 24,
                child: widget.prefixIcon!,
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                textToShow,
                style: style,
              ),
            ),
          ),
          AbsorbPointer(
            absorbing: !editable,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: editable ? 1 : 0,
              child: Builder(builder: (context) {
                VoidCallback? onPressed = widget.onEditPressedOverride ?? _edit;
                if (controller?.currentEditableField.value != null &&
                    controller?.currentEditableField.value != this) {
                  onPressed = null;
                }
                return IconButton(
                  onPressed: onPressed,
                  color: theme.primaryColor,
                  splashRadius: iconButtonSplashRadius,
                  icon: Icon(
                    Icons.edit,
                    size: widget.iconSize,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  void _edit() {
    if (controller != null) {
      controller!.edit(this);
    } else {
      _editing = true;
      setState(() {});
    }
  }

  void _stopEditing() {
    if (controller != null) {
      controller!.stopEditing(this);
    } else {
      _editing = false;
      setState(() {});
    }
  }
}
