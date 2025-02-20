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

  Color get red;

  Color get orange;

  Color get lightGreen;

  Color get lightBlue;
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
  Color get lightGreen => const Color.fromRGBO(51, 175, 51, 1.0);

  @override
  Color get grey500 => Colors.grey.shade500;

  @override
  Color get red => Colors.red;

  @override
  Color get orange => Colors.deepOrangeAccent;

  @override
  Color get lightBlue => const Color.fromRGBO(203, 227, 255, 0.8980392156862745);
}
