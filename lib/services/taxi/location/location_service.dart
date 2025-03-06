import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  final Location location = Location();

  Future<LatLng?> getCurrentLocation() async {
    final locData = await location.getLocation();
    return LatLng(locData.latitude!, locData.longitude!);
  }
}