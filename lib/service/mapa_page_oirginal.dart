import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mapa com OpenStreetMap')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
            -28.0267,
            -49.1235,
          ), // Coordenadas de Gravatal, SC
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName:
                'com.seu.app', // Importante para o OpenStreetMap
          ),
        ],
      ),
    );
  }
}
