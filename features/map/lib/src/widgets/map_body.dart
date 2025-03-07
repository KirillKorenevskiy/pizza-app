import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'bottom_sheet_body.dart';

class MapBody extends StatelessWidget {
  MapBody({super.key});

  final List<LatLng> _markerPositions = <LatLng>[
    const LatLng(53.922178, 27.56908),
    const LatLng(53.909917, 27.496272),
    const LatLng(53.928805, 27.586939),
    const LatLng(53.871222, 27.541781),
    const LatLng(53.874498, 27.633229),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(53.9, 27.5667),
            initialZoom: 11,
          ),
          children: <Widget>[
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayer(
              markers: _markerPositions.map((LatLng point) {
                return Marker(
                  point: point,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => Container(
                          padding: const EdgeInsets.all(16),
                          child: const BottomSheetBody(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 50,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
