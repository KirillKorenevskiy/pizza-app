import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String value;
  final String text;
  final bool isSelected;
  final Function(String) onCategorySelected;

  const CategoryButton({
    required this.value,
    required this.text,
    required this.isSelected,
    required this.onCategorySelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return GestureDetector(
      onTap: () {
        onCategorySelected(value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: isSelected ? colors.primaryBg : colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? colors.white : colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
