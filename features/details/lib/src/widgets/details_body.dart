import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/details_cubit.dart';
import 'ingredient_item.dart';
import 'macros_item.dart';

class DetailsBody extends StatelessWidget {
  final Pizza pizza;

  const DetailsBody(this.pizza, {super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (BuildContext context, DetailsState state) {
        return MaterialApp(
          home: Scaffold(
            backgroundColor: colors.grey,
            body: NestedScrollView(
              floatHeaderSlivers: true,
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    scrolledUnderElevation: 0,
                    expandedHeight: 450,
                    backgroundColor: colors.grey,
                    pinned: true,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                        'core_ui/assets/${pizza.picture}',
                      ),
                      title: Text(
                        pizza.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      centerTitle: true,
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    DefaultTabController(
                      length: 3,
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: AppColors.of(context).grey500.withAlpha(150),
                        ),
                        child: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorAnimation: TabIndicatorAnimation.elastic,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: AppColors.of(context).grey.withAlpha(130),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          labelColor: AppColors.of(context).black,
                          unselectedLabelColor: AppColors.of(context).black,
                          tabs: const <Widget>[
                            Text(
                              '25',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '30',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '35',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Add some ingredients',
                      style: TextStyle(fontSize: 20),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.ingredients.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 13.0,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final Ingredient ingredient = state.ingredients[index];
                        return IngredientItem(ingredient: ingredient);
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MacrosItem(
                          title: 'Calories',
                          value: pizza.macros.calories,
                          icon: Icons.local_fire_department_rounded,
                        ),
                        MacrosItem(
                          title: 'Protein',
                          value: pizza.macros.proteins,
                          icon: Icons.sports_gymnastics,
                        ),
                        MacrosItem(
                          title: 'Fat',
                          value: pizza.macros.fat,
                          icon: Icons.fastfood_rounded,
                        ),
                        MacrosItem(
                          title: 'Carbs',
                          value: pizza.macros.carbs,
                          icon: Icons.breakfast_dining,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          elevation: 3.0,
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '+ Add to cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
