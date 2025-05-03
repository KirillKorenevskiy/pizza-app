import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  final String image;
  final String name;
  final String quantity;
  final int price;

  const RecommendationCard({
    required this.image,
    required this.name,
    required this.quantity,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);
    
    return Container(
      margin: const EdgeInsets.all(6),
      width: 125,
      height: 250,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 65),
            decoration: BoxDecoration(
              color: colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: colors.grey500.withAlpha(100),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 45,
                left: 8,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      color: colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    quantity,
                    style: TextStyle(
                      color: colors.grey500,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          Image.network(
            'https://ympofjjzwcdlmiaoxeik.supabase.co/storage/v1/object/public/pizzas//$image',
            height: 110,
            width: 120,
          ),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '$price\$',
                  style: TextStyle(
                    color: colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
