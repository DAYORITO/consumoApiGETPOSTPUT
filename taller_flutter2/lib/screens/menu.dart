import 'package:flutter/material.dart';
import 'package:taller_flutter2/screens/photo.dart';
import 'package:taller_flutter2/screens/residentes.dart';
import 'package:taller_flutter2/screens/vehiculos.dart';
import 'package:taller_flutter2/screens/listar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late GoogleMapController mapController;
  Map<String, Marker> markers = {};

  final LatLng _center = const LatLng(25.1193, 55.3773);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Residentes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InterfazResidentes()),
                );
              },
            ),
            ListTile(
              title: const Text('Visitantes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UniversalApi()),
                );
              },
            ),
            ListTile(
              title: const Text('Vehiculos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListarVehiculos()),
                );
              },
            ),
            ListTile(
              title: const Text('Camara'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraApp()),
                );
              },
            ),
          ],
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 14,
        ),
        onMapCreated: (controller) {
          mapController = controller;
          addMarker();
        },
        markers: markers.values.toSet(),
      ),
    );
  }

  addMarker() {
    final marker = Marker(
      markerId: const MarkerId('1'),
      position: const LatLng(25.1193, 55.3773),
      infoWindow: const InfoWindow(title: 'Dubai'),
    );
    setState(() {
      markers['1'] = marker;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
