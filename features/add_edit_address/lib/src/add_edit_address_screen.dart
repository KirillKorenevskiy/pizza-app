import 'package:auto_route/annotations.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'bloc/add_edit_address_cubit.dart';
import 'widget/add_edit_address_body.dart';

@RoutePage()
class AddEditAddressScreen extends StatelessWidget {
  final String initialAddress;
  final LatLng latLng;
  final bool isEditingMode;
  final String? addressId;

  const AddEditAddressScreen({
    required this.initialAddress,
    required this.latLng,
    required this.isEditingMode,
    this.addressId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddEditAddressCubit>(
      create: (BuildContext context) => AddEditAddressCubit(
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
      ),
      child: AddEditAddressBody(
        initialAddress: initialAddress,
        latLng: latLng,
        isEditingMode: isEditingMode,
        addressId: addressId,
      ),
    );
  }
}
