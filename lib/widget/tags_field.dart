import 'package:flutter/material.dart';
import 'package:grocery_genie/models/tag.dart';
import 'package:grocery_genie/widget/editable_text_field.dart';
import 'package:grocery_genie/widget/editable_text_form.dart';

class TagsField extends StatefulWidget {
  final List<Tag> tags;
  final void Function() onChange;
  const TagsField({
    required this.tags,
    required this.onChange,
    super.key,
  });

  @override
  State<TagsField> createState() => _TagsFieldState();
}

class _TagsFieldState extends State<TagsField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final editableController = EditableController.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags:',
          style: theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<bool>(
          valueListenable: editableController?.editable ?? ValueNotifier<bool>(true),
          builder: (context, editing, _) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: !editing
                  ? const SizedBox.shrink()
                  : EditableTextField(
                    hint: 'New tag',
                      behaviors: const [
                        EditableTextBehavior.clearOnConfirm,
                      ],
                      onValueConfirmed: (String string) async {
                        final bool tagDoesNotExistYet =
                            widget.tags.where((tag) => tag.title == string).isEmpty;
                        if (tagDoesNotExistYet && string.trim() != '') {
                          widget.tags.add(Tag(title: string));
                          widget.onChange();
                          setState(() {});
                        }
                      },
                    ),
            );
          },
        ),
        Wrap(
          children: [
            for (final tag in widget.tags) //
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.fromLTRB(20, 5, 12, 5),
                    textStyle: const TextStyle(fontSize: 16)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(tag.title),
                    InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: () => removeTag(tag),
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.close,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  void removeTag(Tag tag) {
    widget.onChange();
    widget.tags.remove(tag);
    setState(() {});
  }
}
