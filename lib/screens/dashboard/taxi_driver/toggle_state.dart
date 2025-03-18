import 'package:dailyfairdeal/services/taxi/location/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TaxiController extends GetxController {
  RxBool isAvailable = false.obs;
  Rx<LatLng?> currentPosition = Rx<LatLng?>(null);
  GoogleMapController? mapController;

  Future<void> toggleAvailability(bool value) async {
    isAvailable.value = value;
    if (value) {
      await getCurrentLocation();
    } else {
      currentPosition.value = null;
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      // Position position = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.high);
      LatLng? position = await LocationService().getCurrentLocation();
      currentPosition.value = LatLng(position!.latitude, position.longitude);
      mapController?.animateCamera(CameraUpdate.newLatLng(currentPosition.value!));
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }
}