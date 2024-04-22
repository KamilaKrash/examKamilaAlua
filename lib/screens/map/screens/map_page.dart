import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(43.23, 76.88);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 8.0,
        ),
        markers: {
          const Marker(
            markerId: MarkerId('ATA'),
            position: LatLng(43.23, 76.88),
            infoWindow: InfoWindow(
              title: "Алматы",
              snippet: "Мой город",
            ),
          ),
          const Marker(
            markerId: MarkerId('MEGA'),
            position: LatLng(43.201, 76.893),
            infoWindow: InfoWindow(
              title: "Мега",
              snippet: "Мой любимый ТЦ",
            ),
          ),
        },
      ),
    );
  }
}