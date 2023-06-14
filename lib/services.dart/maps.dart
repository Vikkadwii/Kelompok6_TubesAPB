import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition initialPosition = CameraPosition(
      target: LatLng(-6.975350292012472, 107.64026452915705), zoom: 14.0);

  static const CameraPosition targetPosition = CameraPosition(
      target: LatLng(-6.16775452496729, 106.8053655241306),
      zoom: 14.0,
      //sudut orientasi
      bearing: 192.0,
      //sudut miring
      tilt: 60);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          konsultasi();
        },
        label: const Text("Konsultasi Bersama"),
        icon: const Icon(Icons.local_hospital_outlined),
      ),
    );
  }

  Future<void> konsultasi() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));
  }
}
