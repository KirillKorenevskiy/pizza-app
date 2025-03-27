import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import '../bloc/placing_order_cubit.dart';
import '../utils/date_utils.dart';
import '../utils/time_utils.dart';
import 'address_card.dart';
import 'delivery_time_item.dart';
import 'payment_method_item.dart';

class PlacingOrderBody extends StatelessWidget {
  final Address address;

  const PlacingOrderBody({
    required this.address,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);
    final List<String> timeSlots = TimeUtils.generateTimeSlots();

    return BlocBuilder<PlacingOrderCubit, PlacingOrderState>(
      builder: (BuildContext context, PlacingOrderState state) {
        final PlacingOrderCubit cubit = context.read<PlacingOrderCubit>();

        final bool isOrderValid = state.selectedPaymentMethod.isNotEmpty &&
            state.selectedDeliveryTime.isNotEmpty;

        return Scaffold(
          appBar: AppBar(
            title: Text(context.locale.placingOrder),
            backgroundColor: colors.white,
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  context.locale.placeToOrder,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              AddressCard(
                address: address,
              ),
              const SizedBox(height: 15),
              if (address.type == 'pizzeria')
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    context.locale.workingHours + AppConstants.WORKING_HOURS,
                    style: TextStyle(
                      fontSize: 20,
                      color: colors.grey500,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  context.locale.timeToOrder,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: 65,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: timeSlots.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String time = timeSlots[index];
                      return GestureDetector(
                        onTap: () {
                          cubit.selectDeliveryTime(time);
                        },
                        child: DeliveryTimeWidget(
                          deliveryTime: time,
                          isSelected: state.selectedDeliveryTime == time,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  context.locale.paymentMethods,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: 250,
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      final PaymentMethod method = PaymentMethod.values[index];
                      return GestureDetector(
                        onTap: () {
                          cubit.selectPaymentMethod(method);
                        },
                        child: PaymentMethodItem(
                          paymentMethod: method,
                          isSelected:
                              state.selectedPaymentMethod == method.label,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            height: 135,
            child: Column(
              children: <Widget>[
                address.type == 'pizzeria'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Icon(
                            Icons.warning_amber_rounded,
                            size: 24,
                            color: Colors.red,
                          ),
                          Text(
                            context.locale.onlyPickup,
                            style: TextStyle(
                              fontSize: 16,
                              color: colors.red,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            context.locale.deliveryFee,
                            style: TextStyle(
                              color: colors.grey500,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            context.locale.free,
                            style: TextStyle(
                              color: colors.grey500,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      context.locale.orderPrice,
                      style: TextStyle(
                        color: colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${context.read<AppCubit>().state.cartPrice}',
                      style: TextStyle(
                        color: colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isOrderValid
                        ? () {
                            final String userId =
                                context.read<AppCubit>().state.user!.userId;
                            final double price =
                                context.read<AppCubit>().state.cartPrice;
                            final List<String> cartItems = state.cartItems;

                            final Order order = Order(
                              id: '',
                              userId: userId,
                              date: CustomDateUtils.getCurrentDate(),
                              address: address.address,
                              price: price,
                              items: cartItems,
                            );

                            cubit.addOrder(order);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primaryBg,
                    ),
                    child: Text(
                      context.locale.confirmDelivery,
                      style: TextStyle(
                        fontSize: 18,
                        color: colors.white,
                      ),
                    ),
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
