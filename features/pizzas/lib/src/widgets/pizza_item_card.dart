import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/src/models/pizza_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bloc/pizzas_cubit.dart';

class PizzaCard extends StatelessWidget {
  final Pizza pizza;

  const PizzaCard({
    required this.pizza,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PizzasCubit, PizzasState>(
      buildWhen: (PizzasState previous, PizzasState current) =>
          previous.cartItems != current.cartItems,
      builder: (BuildContext context, PizzasState state) {
        final AppColors colors = AppColors.of(context);
        final bool isInCart = state.cartItems.contains(pizza.pizzaId);
        final int price = pizza.price;
        final int discount = pizza.discount;

        return Container(
          margin: const EdgeInsets.only(bottom: 9),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: () {
              context.read<PizzasCubit>().goToDetails(pizza);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'core_ui/assets/${pizza.picture}',
                  height: 150,
                  width: 150,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: pizza.isVegetarian
                                  ? colors.lightGreen
                                  : colors.red,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            child: Text(
                              pizza.isVegetarian
                                  ? context.locale.veg
                                  : context.locale.nonVeg,
                              style: TextStyle(
                                color: colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green.withAlpha(45),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            child: Text(
                              pizza.spicy == 1
                                  ? context.locale.bland
                                  : pizza.spicy == 2
                                      ? context.locale.balance
                                      : context.locale.spicy,
                              style: TextStyle(
                                color: pizza.spicy == 1
                                    ? colors.green
                                    : pizza.spicy == 2
                                        ? colors.orange
                                        : colors.red,
                                fontWeight: FontWeight.w800,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        pizza.name,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        pizza.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: colors.grey500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                pizza.discount > 0
                                    ? '\$${(price - (price * discount / 100)).toStringAsFixed(2)}'
                                    : '\$${pizza.price}.00',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: colors.primaryBg,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 5),
                              if (discount > 0)
                                Text(
                                  '\$$price.00',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colors.grey500,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<PizzasCubit>()
                                  .toggleCart(pizza.pizzaId);
                            },
                            icon: Icon(
                              isInCart
                                  ? CupertinoIcons.check_mark_circled_solid
                                  : CupertinoIcons.add_circled_solid,
                              color: isInCart ? colors.primaryBg : colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
