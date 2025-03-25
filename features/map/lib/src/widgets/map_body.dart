import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/src/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

import '../bloc/map_cubit.dart';

class MapBody extends StatefulWidget {
  final bool isEditingMode;
  final Address? address;

  const MapBody({
    required this.isEditingMode,
    this.address,
    super.key,
  });

  @override
  _MapBodyState createState() => _MapBodyState();
}

class _MapBodyState extends State<MapBody> {
  late MapController _mapController;
  LatLng _currentLatLng = AppConstants.MAP_INITIAL_CENTER;
  String _currentAddress = '';

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    if (widget.isEditingMode && widget.address != null) {
      _currentLatLng = LatLng(
        widget.address!.latitude,
        widget.address!.longitude,
      );
      _currentAddress = widget.address!.address;
      context.read<MapCubit>().switchEditingMode();
    } else {
      _currentLatLng = AppConstants.MAP_INITIAL_CENTER;
    }
  }

  Future<void> _onMapTapped(
    BuildContext context,
    LatLng latLng,
  ) async {
    final bool isAddingMode = context.read<MapCubit>().state.isAddingMode;
    final bool isEditingMode = context.read<MapCubit>().state.isEditingMode;

    if (isAddingMode || isEditingMode) {
      setState(() {
        _currentLatLng = latLng;
      });
      await _getAddressFromCoordinates(latLng);
    }
  }

  Future<void> _getAddressFromCoordinates(LatLng latLng) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );
    if (placemarks.isNotEmpty) {
      setState(() {
        _currentAddress =
            '${placemarks.first.street}, ${placemarks.first.locality}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return BlocListener<MapCubit, MapState>(
      listenWhen: (MapState previous, MapState current) =>
          previous.isEditingMode == true && current.isEditingMode == false,
      listener: (BuildContext context, MapState state) {
        context.read<MapCubit>().goBack();
      },
      child: BlocBuilder<MapCubit, MapState>(
        builder: (BuildContext context, MapState state) {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _currentLatLng,
                    initialZoom: 12,
                    onTap: (
                      TapPosition tapPosition,
                      LatLng latLng,
                    ) {
                      _onMapTapped(context, latLng);
                    },
                  ),
                  children: <Widget>[
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    if (!state.isAddingMode && !state.isEditingMode)
                      MarkerLayer(
                        markers: state.addresses.map((Address address) {
                          return Marker(
                            point: LatLng(
                              address.latitude,
                              address.longitude,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<MapCubit>()
                                    .goToPlacingOrder(address);
                              },
                              child: address.type == 'pizzeria'
                                  ? Icon(
                                      Icons.local_pizza_rounded,
                                      size: 50,
                                      color: colors.red,
                                    )
                                  : address.type == 'work'
                                      ? Icon(
                                          Icons.work,
                                          size: 50,
                                          color: colors.black,
                                        )
                                      : Icon(
                                          Icons.home,
                                          size: 50,
                                          color: colors.green,
                                        ),
                            ),
                          );
                        }).toList(),
                      ),
                    if (state.isAddingMode || state.isEditingMode)
                      MarkerLayer(
                        markers: <Marker>[
                          Marker(
                            point: _currentLatLng,
                            child: Icon(
                              Icons.location_pin,
                              color: colors.primaryBg,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                !state.isEditingMode
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 45,
                            left: 20,
                          ),
                          child: FloatingActionButton(
                            onPressed: () {
                              context.read<MapCubit>().goBack();
                            },
                            backgroundColor: colors.white,
                            shape: const CircleBorder(),
                            child: Icon(
                              Icons.arrow_back,
                              color: colors.black,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(width: 1),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 45,
                      right: 20,
                    ),
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      backgroundColor: colors.white,
                      onPressed: () {
                        state.isEditingMode
                            ? context.read<MapCubit>().switchEditingMode()
                            : context.read<MapCubit>().switchAddingMode();
                      },
                      child: Icon(
                        state.isAddingMode || state.isEditingMode
                            ? Icons.close
                            : Icons.add,
                        color: colors.black,
                      ),
                    ),
                  ),
                ),
                if (state.isAddingMode || state.isEditingMode)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<MapCubit>().goToAddEditAddress(
                                initialAddress: _currentAddress,
                                latLng: _currentLatLng,
                                isEditingMode: widget.isEditingMode,
                                addressId: widget.address?.id,
                              );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            state.isEditingMode
                                ? 'Обновить адрес'
                                : 'Добавить адрес',
                            style: TextStyle(
                              color: colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
