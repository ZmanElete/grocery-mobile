import 'package:flutter/material.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';
import 'package:guru_provider/guru_provider/repository.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final StateKey<double> fontScaleKey = StateKey(() => 1);

/// Plugin that allows wrapping each story into a device frame.
class FontScalePlugin extends Plugin {
  FontScalePlugin({
    List<DeviceInfo>? deviceInfos,
    double initialScale = 1,
  }) : super(
          icon: _buildIcon,
          storyBuilder: _buildStoryWrapper,
          panelBuilder: (context) => _buildPanel(context, deviceInfos),
        ) {
    Repository.instance.set(fontScaleKey, initialScale);
  }
}

Widget? _buildIcon(_1) => const Icon(Icons.text_fields);

Widget _buildStoryWrapper(BuildContext context, Widget? child) {
  final query = MediaQuery.of(context);
  return MediaQuery(
    data: query.copyWith(
      textScaler: TextScaler.linear(
        Repository.instance.watch(fontScaleKey, context),
      ),
    ),
    child: child!,
  );
}

Widget _buildPanel(context, deviceInfos) {
  final currentScale = Repository.instance.watch(fontScaleKey, context);
  final query = MediaQuery.of(context);
  return MediaQuery(
    data: query.copyWith(
      textScaler: TextScaler.noScaling,
    ),
    child: Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16),
        child: Text(
          'Font Scale',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      Expanded(
        child: ListView(
          children: [
            for (int i = 50; i <= 300; i += 25)
              ListTile(
                title: Text('$i%'),
                trailing: i == (currentScale * 100) ? const Icon(Icons.check) : null,
                onTap: () {
                  Repository.instance.set(fontScaleKey, i / 100);
                },
              ),
          ],
        ),
      ),
    ]),
  );
}
