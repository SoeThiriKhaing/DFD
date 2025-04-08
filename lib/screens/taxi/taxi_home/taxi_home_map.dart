import 'package:dailyfairdeal/screens/taxi/taxi_home/taxi_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TaxiHomeMap extends StatelessWidget {
  final TaxiHomeController controller;
  const TaxiHomeMap({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: controller.currentLocation ?? const LatLng(16.8409, 96.1735), zoom: 14.0,),
            markers: controller.markers,
            polylines: controller.polylines,
            onMapCreated: controller.onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: true,
            rotateGesturesEnabled: true,
            onCameraMove: (position) {
              controller.updateCameraPosition(position);
            },
          ),
        ],
      ),
    );
  }
}
