import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class DeliveryTimeWidget extends StatelessWidget {
  final String deliveryTime;
  final bool isSelected;

  const DeliveryTimeWidget({
    super.key,
    required this.deliveryTime,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return Container(
      margin: const EdgeInsets.only(
        top: 8,
        bottom: 8,
        right: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: isSelected ? colors.primaryBg : colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? colors.primaryBg : colors.grey500,
        ),
      ),
      child: Center(
        child: Text(
          deliveryTime,
          style: TextStyle(
            color: isSelected ? colors.white : colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
