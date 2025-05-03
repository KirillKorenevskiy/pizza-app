import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/adminka_cubit.dart';
import 'add_edit_pizza_screen.dart';

class AdminkaBody extends StatelessWidget {
  const AdminkaBody({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin panel'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<AdminkaCubit, AdminkaState>(
        builder: (BuildContext context, AdminkaState state) {
          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.error != null) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          }

          if (state.pizzas.isEmpty) {
            return const Center(
              child: Text('No pizzas found'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await context.read<AdminkaCubit>().loadPizzas();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.pizzas.length,
              itemBuilder: (BuildContext context, int index) {
                final Pizza pizza = state.pizzas[index];

                return Card(
                  color: colors.grey.withAlpha(150),
                  shadowColor: colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://ympofjjzwcdlmiaoxeik.supabase.co/storage/v1/object/public/pizzas//${pizza.picture}',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      pizza.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Price: ${pizza.price}\$',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    trailing: Wrap(
                      spacing: 6,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: colors.primaryBg,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    BlocProvider<AdminkaCubit>(
                                  create: (BuildContext context) =>
                                      AdminkaCubit(appLocator.get()),
                                  child: AddOrEditPizzaScreen(
                                    initialPizza: pizza,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: colors.red,
                          ),
                          onPressed: () async {
                            final bool? confirmed = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete pizza'),
                                  content: Text(
                                    'Are you sure you want to delete "${pizza.name}"?',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmed ?? false) {
                              await context
                                  .read<AdminkaCubit>()
                                  .deletePizza(pizza.pizzaId);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => BlocProvider<AdminkaCubit>(
                create: (BuildContext context) => AdminkaCubit(
                  appLocator.get(),
                ),
                child: AddOrEditPizzaScreen(
                  onPizzaAdded: () {
                    context.read<AdminkaCubit>().loadPizzas();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
