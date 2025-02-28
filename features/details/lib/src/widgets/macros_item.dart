import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class MacrosItem extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;

  const MacrosItem({
    required this.title,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 4),
              Text(
                title == 'Calories' ? '$value \n$title' : '$value \n$title',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.of(context).black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
