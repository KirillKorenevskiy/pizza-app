import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final int index;
  final ValueChanged<int> onQuantityChanged;

  const CartItemCard({
    super.key,
    required this.cartItem,
    required this.index,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);
    final int price = cartItem.pizza.price;
    final int discount = cartItem.pizza.discount;
    final Macros macros = cartItem.pizza.macros;

    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.grey,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'core_ui/assets/${cartItem.pizza.picture}',
                width: 120,
                height: 120,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cartItem.pizza.name,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Calories: ${macros.calories} (p: ${macros.proteins}, '
                      'f: ${macros.fat}, c: ${macros.carbs}) '
                      '\nSpicy level: ${cartItem.pizza.spicy}',
                      style: TextStyle(
                        color: colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  ((price * (1 - (discount / 100))) * cartItem.quantity)
                          .toStringAsFixed(2) +
                      r'$',
                  style: TextStyle(
                    color: colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              UpDownButton(
                quantity: cartItem.quantity,
                onValueChanged: onQuantityChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
