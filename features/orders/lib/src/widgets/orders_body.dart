import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/orders_cubit.dart';
import 'order_item.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (BuildContext context, OrdersState state) {
        final AppColors colors = AppColors.of(context);
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: Text(context.locale.orders),
            centerTitle: true,
            backgroundColor: colors.white,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                context.read<OrdersCubit>().goBack();
              },
            ),
          ),
          body: state.orders.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Order order = state.orders[index];

                    return OrderItem(
                      order: order,
                    );
                  },
                ),
        );
      },
    );
  }
}
