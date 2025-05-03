import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/src/models/pizza_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bloc/pizzas_cubit.dart';
import 'pizza_item_card.dart';

class PizzasScreenBody extends StatelessWidget {
  const PizzasScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return BlocBuilder<PizzasCubit, PizzasState>(
      builder: (BuildContext context, PizzasState state) {
        return Scaffold(
          backgroundColor: colors.grey,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: colors.grey,
            title: Row(
              children: <Widget>[
                Image.network(
                  'https://ympofjjzwcdlmiaoxeik.supabase.co/storage/v1/object/public/pizzas//8.png',
                  scale: 14,
                ),
                const SizedBox(width: 8),
                Text(
                  context.locale.pizza,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  context.read<PizzasCubit>().goToCart();
                },
                icon: const Icon(
                  CupertinoIcons.cart_fill,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<PizzasCubit>().goToProfile();
                },
                icon: const Icon(
                  CupertinoIcons.profile_circled,
                  size: 35,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await context.read<PizzasCubit>().getPizzas();
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : state.errorMessage != null
                      ? Center(
                          child: Text(context.locale.errorHasOccurred),
                        )
                      : ListView.builder(
                          itemCount: state.pizzas.length,
                          itemBuilder: (BuildContext context, int i) {
                            final Pizza pizza = state.pizzas[i];

                            return PizzaCard(
                              pizza: pizza,
                            );
                          },
                        ),
            ),
          ),
        );
      },
    );
  }
}
