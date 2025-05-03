import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final int index;
  final ValueChanged<int> onQuantityChanged;
  final int size;

  const CartItemCard({
    super.key,
    required this.cartItem,
    required this.index,
    required this.onQuantityChanged,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);
    final Macros macros = cartItem.pizza.macros;

    final List<String> ingredientNames = cartItem.additionalIngredients
        .map((Ingredient ingredient) => ingredient.name)
        .toList();

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
              Image.network(
                'https://ympofjjzwcdlmiaoxeik.supabase.co/storage/v1/object/public/pizzas//${cartItem.pizza.picture}',
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
                      context.locale.caloriesInCart(
                        macros.calories,
                        macros.carbs,
                        macros.fat,
                        macros.proteins,
                      ),
                      style: TextStyle(
                        color: colors.black,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      context.locale.size(size),
                      style: TextStyle(
                        color: colors.black,
                        fontSize: 15,
                      ),
                    ),
                    (ingredientNames.isNotEmpty)
                        ? Text(
                            '+ ${ingredientNames.join(', ')}',
                            style: TextStyle(
                              color: colors.black,
                              fontSize: 15,
                            ),
                          )
                        : const Text(''),
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
                  cartItem.totalPrice.toStringAsFixed(2) + r'$',
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
