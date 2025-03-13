import 'package:core/core.dart';
import 'package:domain/src/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../bloc/map_cubit.dart';
import 'bottom_sheet_body.dart';

class MapBody extends StatelessWidget {
  const MapBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (BuildContext context, MapState state) {
        return state.isLoading
            ? const CircularProgressIndicator()
            : Scaffold(
                body: Stack(
                  children: <Widget>[
                    FlutterMap(
                      options: const MapOptions(
                        initialCenter: AppConstants.MAP_INITIAL_CENTER,
                        initialZoom: 11,
                      ),
                      children: <Widget>[
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName:
                              'dev.fleaflet.flutter_map.example',
                        ),
                        MarkerLayer(
                          markers:
                              state.addresses.map((Address pizzeria) {
                            return Marker(
                              point: LatLng(
                                pizzeria.latitude,
                                pizzeria.longitude,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        Container(
                                      padding: const EdgeInsets.all(16),
                                      child: BottomSheetBody(
                                        address: pizzeria.address,
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.local_pizza_rounded,
                                  color: Colors.red,
                                  size: 55,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40.0, left: 20),
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          child:
                              const Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
