import 'package:grocery_genie/app.dart';
import 'package:grocery_genie/storybook/font_scale_plugin.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final storybook = Storybook(
  initialStory: 'App',
  plugins: {
    DeviceFramePlugin(),
    ThemeModePlugin(),
    FontScalePlugin(),
  },
  wrapperBuilder: (_, child) {
    if (child is App) {
      return child;
    }
    return materialWrapper(_, child);
  },
  stories: [
    Story(
      name: 'App',
      builder: (_) => const App(),
    ),
  ],
);
