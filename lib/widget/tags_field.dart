import 'package:flutter/material.dart';
import 'package:grocery_genie/managers/tags_manager.dart';
import 'package:grocery_genie/models/tag.dart';
import 'package:grocery_genie/widget/editable_text_form.dart';

class TagsField extends StatefulWidget {
  final List<Tag> tags;
  final void Function() onChange;
  final String onType;
  const TagsField({
    required this.tags,
    required this.onChange,
    this.onType = '',
    super.key,
  });

  @override
  State<TagsField> createState() => _TagsFieldState();
}

class _TagsFieldState extends State<TagsField> {
  @override
  void initState() {
    TagsManager.instance.getList();
    super.initState();
  }

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
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 4,
          runSpacing: 4,
          children: [
            for (final tag in widget.tags) //
              Container(
                padding: const EdgeInsets.fromLTRB(12, 5, 10, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.primaryColor,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tag.title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: () => removeTag(tag),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Icon(
                          Icons.close,
                          size: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(
              width: 3,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: editableController?.editable ?? ValueNotifier<bool>(true),
              builder: (context, editing, _) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: !editing
                      ? const SizedBox.shrink()
                      : InkWell(
                          borderRadius: BorderRadius.circular(200),
                          onTap: () => addTag(context),
                          child: const Icon(
                            Icons.add,
                            size: 30,
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> addTag(BuildContext context) async {
    final Tag? tag = await showSearch(
      context: context,
      delegate: TagSearchDelegate(
        filterTags: widget.tags,
      ),
    );
    if (tag != null) {
      widget.tags.add(tag);
      widget.onChange();
      setState(() {});
    }
  }

  void removeTag(Tag tag) {
    widget.onChange();
    widget.tags.remove(tag);
    setState(() {});
  }
}

class TagSearchDelegate extends SearchDelegate<Tag> {
  List<Tag> filterTags;
  TagSearchDelegate({
    this.filterTags = const [],
  }) : super(
          searchFieldLabel: 'Tag',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
        );

  @override
  void showResults(BuildContext context) {
    getOrCreateTag(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    final theme = Theme.of(context);
    return [
      IconButton(
        onPressed: query.isNotEmpty ? () => getOrCreateTag(context) : null,
        color: theme.primaryColor,
        icon: const Icon(Icons.add),
      ),
      IconButton(
        onPressed: query.isNotEmpty ? () => query = '' : null,
        color: theme.primaryColor,
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  void getOrCreateTag(BuildContext context) {
    Tag? tag;
    if (query.trim() != '') {
      tag = TagsManager.instance.list.value!.cast<Tag?>().firstWhere(
            (tag) => tag?.title.trim() == query.trim(),
            orElse: () => null,
          );

      tag ??= Tag(title: query.trim());
      close(context, tag);
    }
    query = '';
  }

  @override
  Widget? buildLeading(BuildContext context) {
    final theme = Theme.of(context);
    return BackButton(
      color: theme.primaryColor,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // final theme = Theme.of(context);
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      child: ValueListenableBuilder<List<Tag>?>(
        valueListenable: TagsManager.instance.list,
        builder: (context, allTags, _) {
          final tags = allTags!.where(
            (tag) => tag.title.contains(query) && !filterTags.contains(tag),
          );

          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 5,
            runSpacing: 6,
            children: [
              for (final tag in tags) //
                Material(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      close(context, tag);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(13, 6, 13, 6),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tag.title,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
