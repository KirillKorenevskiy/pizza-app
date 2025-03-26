import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/placing_order_cubit.dart';

class AddressCard extends StatelessWidget {
  final Address address;

  const AddressCard({
    required this.address,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.of(context).grey,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              address.type == 'home'
                  ? Icons.home
                  : address.type == 'work'
                      ? Icons.work
                      : Icons.local_pizza_rounded,
              size: 40,
              color: AppColors.of(context).black,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    address.address,
                    style: TextStyle(
                      color: AppColors.of(context).black,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Дополнительная информация',
                    style: TextStyle(
                      color: AppColors.of(context).grey500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            address.type == 'pizzeria'
                ? const SizedBox(width: 1)
                : IconButton(
                    onPressed: () =>
                        context.read<PlacingOrderCubit>().goToMap(address),
                    icon: Icon(
                      Icons.edit,
                      color: AppColors.of(context).black,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
