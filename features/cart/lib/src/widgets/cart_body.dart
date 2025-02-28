import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/cart_cubit.dart';
import 'cart_item_card.dart';
import 'promo_code_field.dart';
import 'recommendation_card.dart';

class CartBody extends StatefulWidget {
  const CartBody({super.key});

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  final TextEditingController _promoCodeController = TextEditingController();

  void _onQuantityChanged(int index, int newQuantity) {
    context.read<CartCubit>().updateQuantity(
          index,
          newQuantity,
        );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);
    const double minOrderPrice = AppConstants.MIN_ORDER_PRICE;

    return BlocBuilder<CartCubit, CartState>(
      builder: (BuildContext context, CartState state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: Text(context.locale.cart),
            centerTitle: true,
            backgroundColor: colors.white,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                context.read<CartCubit>().closeCart();
              },
            ),
          ),
          body: state.errorMessage?.isNotEmpty ?? false
              ? Center(
                  child: Text(state.errorMessage ?? ''),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              context.locale.itemFor(
                                state.totalQuantity,
                                state.totalPrice,
                              ),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: colors.black,
                              ),
                            ),
                            state.totalPrice < minOrderPrice
                                ? Text(
                                    context.locale.minOrderPrice(minOrderPrice),
                                    style: TextStyle(
                                      color: colors.red,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      state.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : state.cartItems.isEmpty
                              ? Center(
                                  child: Text(context.locale.cartIsEmpty),
                                )
                              : ListView.builder(
                                  itemCount: state.cartItems.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int i) {
                                    final CartItem cartItem =
                                        state.cartItems[i];

                                    final Details pizzaDetails =
                                        state.detailsItems.firstWhere(
                                      (Details details) =>
                                          details.pizzaId ==
                                          cartItem.pizza.pizzaId,
                                    );

                                    return Dismissible(
                                      key: Key(
                                        state.cartItems[i].pizza.pizzaId,
                                      ),
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        color: colors.red,
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Icon(
                                          Icons.delete,
                                          color: colors.white,
                                        ),
                                      ),
                                      onDismissed:
                                          (DismissDirection direction) {
                                        context
                                            .read<CartCubit>()
                                            .removeFromCart(
                                              state.cartItems[i].pizza.pizzaId,
                                            );
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          context.read<CartCubit>().goToDetails(
                                                state.cartItems[i].pizza,
                                              );
                                        },
                                        child: CartItemCard(
                                          cartItem: state.cartItems[i],
                                          index: i,
                                          onQuantityChanged: (int newQuantity) {
                                            _onQuantityChanged(i, newQuantity);
                                            if (newQuantity == 0) {
                                              context
                                                  .read<CartCubit>()
                                                  .removeFromCart(
                                                    state.cartItems[i].pizza
                                                        .pizzaId,
                                                  );
                                            }
                                          },
                                          size: pizzaDetails.size,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 24),
                            Text(
                              context.locale.addToYourOrder,
                              style: TextStyle(
                                fontSize: 20,
                                color: colors.black,
                              ),
                            ),
                            const SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  RecommendationCard(
                                    image: 'blin.png',
                                    name: 'Pancake with chicken',
                                    quantity: '250g',
                                    price: 9,
                                  ),
                                  RecommendationCard(
                                    image: 'sprite_bottle.png',
                                    name: 'Sprite',
                                    quantity: '500ml',
                                    price: 6,
                                  ),
                                  RecommendationCard(
                                    image: 'wok.png',
                                    name: 'Tai wok with seafood',
                                    quantity: '360g',
                                    price: 10,
                                  ),
                                  RecommendationCard(
                                    image: 'water_bottle.png',
                                    name: 'Watter without gas',
                                    quantity: '500ml',
                                    price: 4,
                                  ),
                                  RecommendationCard(
                                    image: 'carbonara.png',
                                    name: 'Carbonara',
                                    quantity: '450g',
                                    price: 12,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            PromoCodeTextField(
                              controller: _promoCodeController,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: BottomAppBar(
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                state.totalPrice < minOrderPrice
                    ? context.locale.addMoreItems(minOrderPrice)
                    : context.locale.proceedToCheckout(state.totalPrice),
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _promoCodeController.dispose();
    super.dispose();
  }
}
