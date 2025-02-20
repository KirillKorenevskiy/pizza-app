import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientItem({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: AppColors.of(context).white,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              'core_ui/assets/${ingredient.image}',
              width: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Text(
                  ingredient.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${ingredient.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.of(context).black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
