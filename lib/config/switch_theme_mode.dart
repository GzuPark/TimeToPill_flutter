import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:time_to_pill/components/project_colors.dart';
import 'package:time_to_pill/main.dart';

Widget switchThemeMode() {
  return IconButton(
    icon: configRepository.isDark ? const Icon(CupertinoIcons.sun_max) : const Icon(CupertinoIcons.moon_fill),
    onPressed: () => configRepository.switchTheme,
  );
}

Color get getActiveColor {
  return configRepository.isDark ? ProjectColors.primaryDarkColor : ProjectColors.primaryLightColor;
}

Color get getInactiveColor {
  return configRepository.isDark ? ProjectColors.primaryLightColor : ProjectColors.primaryDarkColor;
}
