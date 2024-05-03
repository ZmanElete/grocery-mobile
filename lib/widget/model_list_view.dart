import 'package:flutter/material.dart';
import 'package:grocery_genie/managers/list_manager.dart';
import 'package:guru_flutter_rest/django/api_model.dart';
import 'package:guru_flutter_rest/django/model_rest_service.dart';

class ModelListView<T extends ApiModel, U extends ListManager<T, ModelRestService<T>>>
    extends StatefulWidget {
  final U listManager;
  final Widget Function(BuildContext, T item) itemBuilder;
  final Widget floatingActionButton;

  const ModelListView({
    required this.listManager,
    required this.itemBuilder,
    required this.floatingActionButton,
    super.key,
  });

  @override
  State<ModelListView<T, U>> createState() => _ModelListViewState<T, U>();
}

class _ModelListViewState<T extends ApiModel, U extends ListManager<T, ModelRestService<T>>>
    extends State<ModelListView<T, U>> {
  U get listManager => widget.listManager;

  @override
  void initState() {
    listManager.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      body: ValueListenableBuilder<List<T>?>(
          valueListenable: listManager.list,
          builder: (context, list, _) {
            Widget content;
            if (list == null) {
              content = const Center(child: CircularProgressIndicator());
            } else if (list.isEmpty) {
              content = Center(child: Text(listManager.contentEmpty));
            } else {
              content = ListView.separated(
                itemCount: list.length,
                padding: const EdgeInsets.symmetric(vertical: 8),
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return widget.itemBuilder(context, list[index]);
                },
              );
            }

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: content,
            );
          }),
    );
  }
}
