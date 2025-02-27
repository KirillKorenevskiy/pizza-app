import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/details_cubit.dart';
import 'ingredient_item.dart';
import 'macros_item.dart';

class DetailsBody extends StatefulWidget {
  final Pizza pizza;

  const DetailsBody({
    required this.pizza,
    super.key,
  });

  @override
  State<DetailsBody> createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<PizzaSize> sizes = PizzaSize.values;
  final List<int> pizzaSizes = PizzaSize.values
      .map(
        (PizzaSize size) => size.sizeInCm,
      )
      .toList();

  @override
  void initState() {
    super.initState();
    context.read<DetailsCubit>().getDetails(widget.pizza.pizzaId);
    _tabController = TabController(
      length: pizzaSizes.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return BlocListener<DetailsCubit, DetailsState>(
      listenWhen: (DetailsState previous, DetailsState current) =>
          previous.size != current.size,
      listener: (BuildContext context, DetailsState state) {
        final int index = pizzaSizes.indexOf(state.size);
        if (index != -1) {
          _tabController.index = index;
        }
      },
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (BuildContext context, DetailsState state) {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: colors.grey,
              body: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    scrolledUnderElevation: 0,
                    expandedHeight: 450,
                    backgroundColor: colors.grey,
                    pinned: true,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: colors.black,
                      ),
                      onPressed: () {
                        context.read<DetailsCubit>().goBack();
                      },
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                        'core_ui/assets/${widget.pizza.picture}',
                      ),
                      title: Text(
                        widget.pizza.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      centerTitle: true,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          DefaultTabController(
                            length: 3,
                            child: Container(
                              height: 40,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colors.grey500.withAlpha(150),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorAnimation:
                                    TabIndicatorAnimation.elastic,
                                dividerColor: colors.transparent,
                                indicator: BoxDecoration(
                                  color: colors.grey.withAlpha(130),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelColor: colors.black,
                                unselectedLabelColor: colors.black,
                                tabs: sizes.map((PizzaSize size) {
                                  return Text(
                                    size.toLabel(),
                                    style: const TextStyle(fontSize: 16),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            context.locale.addSomeIngredients,
                            style: const TextStyle(fontSize: 23),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final Ingredient ingredient =
                              state.ingredients[index];

                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<DetailsCubit>()
                                  .toggleIngredient(ingredient);
                            },
                            child: IngredientItem(
                              ingredient: ingredient,
                              isSelected: state.selectedIngredients
                                  .contains(ingredient.name),
                            ),
                          );
                        },
                        childCount: state.ingredients.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 13.0,
                        childAspectRatio: 0.6,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              MacrosItem(
                                title: context.locale.calories,
                                value: widget.pizza.macros.calories,
                                icon: Icons.local_fire_department_rounded,
                              ),
                              MacrosItem(
                                title: context.locale.proteins,
                                value: widget.pizza.macros.proteins,
                                icon: Icons.sports_gymnastics,
                              ),
                              MacrosItem(
                                title: context.locale.fat,
                                value: widget.pizza.macros.fat,
                                icon: Icons.fastfood_rounded,
                              ),
                              MacrosItem(
                                title: context.locale.carbs,
                                value: widget.pizza.macros.carbs,
                                icon: Icons.breakfast_dining,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                if (state.isInCart) {
                                  context.read<DetailsCubit>().updateDetails(
                                        widget.pizza.pizzaId,
                                        pizzaSizes[_tabController.index],
                                        state.selectedIngredients,
                                      );
                                } else {
                                  context.read<DetailsCubit>().addToCart(
                                        widget.pizza.pizzaId,
                                        pizzaSizes[_tabController.index],
                                        state.selectedIngredients,
                                      );
                                }
                              },
                              style: TextButton.styleFrom(
                                elevation: 3.0,
                                backgroundColor: state.isInCart
                                    ? colors.lightGreen
                                    : colors.black,
                                foregroundColor: colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                              ),
                              child: Text(
                                state.isInCart
                                    ? context.locale.done
                                    : context.locale.addToCart,
                                style: TextStyle(
                                  color: colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
