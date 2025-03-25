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
    context.read<AddEditAddressCubit>().updateAddressField(initialAddress);
    context.read<AddEditAddressCubit>().updateCategory('home');

    return BlocBuilder<AddEditAddressCubit, AddEditAddressState>(
      builder: (BuildContext context, AddEditAddressState state) {
        final AppColors colors = AppColors.of(context);

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Enter address',
                  style: TextStyle(
                    color: colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(
                    text: state.address,
                  ),
                  style: TextStyle(
                    color: colors.black,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged:
                      context.read<AddEditAddressCubit>().updateAddressField,
                ),
                const SizedBox(height: 20),
                Text(
                  'Choose category',
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
                      text: '🏠 Home',
                      isSelected: state.category == 'home',
                      onCategorySelected: (String category) {
                        context
                            .read<AddEditAddressCubit>()
                            .updateCategory(category);
                      },
                    ),
                    CategoryButton(
                      value: 'work',
                      text: '🏢 Work',
                      isSelected: state.category == 'work',
                      onCategorySelected:
                          context.read<AddEditAddressCubit>().updateCategory,
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
                              context.read<AddEditAddressCubit>().updateAddress(
                                    addressId!,
                                    latLng,
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Update',
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
                              context
                                  .read<AddEditAddressCubit>()
                                  .deleteAddress(addressId!);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.red,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Delete',
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
                      context.read<AddEditAddressCubit>().saveAddress(latLng);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Save',
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
