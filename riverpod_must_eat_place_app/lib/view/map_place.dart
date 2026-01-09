import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPlace extends StatelessWidget {
  final double lat;
  final double lng;
  const MapPlace({super.key, required this.lat, required this.lng});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("위치 보기")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FlutterMap(
          options: MapOptions(initialCenter: LatLng(lat, lng), initialZoom: 15),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.tj.musteatapp',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80,
                  height: 80,
                  point: LatLng(lat, lng),
                  child: Icon(Icons.pin_drop, size: 50, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
