import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              order.date,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colors.black,
              ),
            ),
            Divider(color: colors.primaryBg.withAlpha(100)),
            const SizedBox(height: 8),
            Text(
              order.address,
              style: TextStyle(
                fontSize: 17,
                color: colors.black,
              ),
            ),
            Divider(color: colors.primaryBg.withAlpha(100)),
            const SizedBox(height: 8),
            Text(
              order.items.join(', '),
              style: TextStyle(
                fontSize: 17,
                color: colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Divider(color: colors.primaryBg.withAlpha(100)),
            const SizedBox(height: 12),
            Text(
              '\$${order.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
