import 'package:dailyfairdeal/common_calls/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getAddressFromLatLng(double lat, double lng) async {
    final String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleAPIKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["status"] == "OK" && data["results"].isNotEmpty) {
          return data["results"][0]["formatted_address"];
        } else {
          return "Unknown location";
        }
      } else {
        return "Failed to fetch location";
      }
    } catch (e) {
      return "Error: $e";
    }
  }