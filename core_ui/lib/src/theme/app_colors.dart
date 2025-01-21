import 'package:flutter/material.dart';

abstract class AppColors {
  factory AppColors.of(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return brightness == Brightness.light
        ? const LightColors()
        : const DarkColors();
  }

  Color get primaryBg;

  Color get white;

  Color get grey;

  Color get black;

  Color get green;

  Color get grey500;
}

class DarkColors extends LightColors {
  const DarkColors();
}

class LightColors implements AppColors {
  const LightColors();

  @override
  Color get primaryBg => Colors.blue;

  @override
  Color get white => const Color.fromRGBO(255, 255, 255, 1);

  @override
  Color get grey => Colors.grey.shade200;

  @override
  Color get black => const Color.fromRGBO(15, 15, 15, 1);

  @override
  Color get green => const Color.fromRGBO(0, 128, 0, 1);

  @override
  Color get grey500 => Colors.grey.shade500;
}
