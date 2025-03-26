import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../bloc/add_edit_address_cubit.dart';
import 'category_button.dart';

class AddEditAddressBody extends StatelessWidget {
  final String? addressId;
  final String initialAddress;
  final LatLng latLng;
  final bool isEditingMode;

  const AddEditAddressBody({
    required this.initialAddress,
    required this.latLng,
    required this.isEditingMode,
    this.addressId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditAddressCubit, AddEditAddressState>(
      builder: (BuildContext context, AddEditAddressState state) {
        final AppColors colors = AppColors.of(context);
        final AddEditAddressCubit cubit = context.read<AddEditAddressCubit>();

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  context.locale.enterAddress,
                  style: TextStyle(
                    color: colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(
                    text: initialAddress,
                  ),
                  style: TextStyle(
                    color: colors.black,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  context.locale.chooseCategory,
                  style: TextStyle(
                    color: colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CategoryButton(
                      value: 'home',
                      text: context.locale.home,
                      isSelected: state.category == 'home',
                      onCategorySelected: cubit.updateCategory,
                    ),
                    CategoryButton(
                      value: 'work',
                      text: context.locale.work,
                      isSelected: state.category == 'work',
                      onCategorySelected: cubit.updateCategory,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (isEditingMode) ...<Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (addressId != null) {
                              cubit.updateAddress(
                                addressId!,
                                latLng,
                                initialAddress,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              context.locale.update,
                              style: TextStyle(
                                color: colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (addressId != null) {
                              cubit.deleteAddress(addressId!);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.red,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              context.locale.delete,
                              style: TextStyle(
                                color: colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else
                  ElevatedButton(
                    onPressed: () {
                      cubit.saveAddress(latLng, initialAddress);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        context.locale.save,
                        style: TextStyle(
                          color: colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }
}
