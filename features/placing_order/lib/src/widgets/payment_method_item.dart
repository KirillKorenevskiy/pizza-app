import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final bool isSelected;

  const PaymentMethodItem({
    super.key,
    required this.paymentMethod,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? colors.primaryBg : colors.grey,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? colors.primaryBg : colors.grey500.withAlpha(80),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              paymentMethod.label,
              style: TextStyle(
                fontSize: 18,
                color: isSelected ? colors.white : colors.black,
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.check_circle_outline,
              color: isSelected ? colors.white : colors.grey500,
            ),
          ],
        ),
      ),
    );
  }
}
