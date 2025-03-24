import 'package:dailyfairdeal/controllers/taxi/driver/bid_price_controller.dart';
import 'package:dailyfairdeal/controllers/taxi/driver/travel_controller.dart';
import 'package:dailyfairdeal/models/taxi/driver/travel_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/bid_price_repository.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/travel_repository.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/services/taxi/driver/bid_price_service.dart';
import 'package:dailyfairdeal/services/taxi/driver/travel_service.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class RideRequestsScreen extends StatefulWidget {
  
  const RideRequestsScreen({super.key});

  @override
  RideRequestsScreenState createState() => RideRequestsScreenState();
}

class RideRequestsScreenState extends State<RideRequestsScreen> {
  late int driverId;
  late TravelController travelController;
  late BidPriceController bidPriceController;
  List<TravelModel> rideRequests = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    String? taxiDriverId = await getDriverId(); //Get from secure storage
    driverId = int.parse(taxiDriverId!);
    travelController = Get.put(TravelController(
        travelService:
            TravelService(travelRepository: TravelRepository())));
    bidPriceController = Get.put(BidPriceController(bidPriceService: BidPriceService(bidPriceRepository: BidPriceRepository())));
    _fetchRideRequests();
  }

  Future<void> _fetchRideRequests() async {
    try {
      List<TravelModel> requests = await travelController.fetchRiderRequests(driverId);
      for (var request in requests) {
        request.pickupAddress = await _getAddressFromLatLng(request.pickupLatitude, request.pickupLongitude);
        request.destinationAddress = await _getAddressFromLatLng(request.destinationLatitude, request.destinationLongitude);
      }
      if (mounted) {
        setState(() {
          rideRequests = requests;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = "Error: $e";
          isLoading = false;
        });
      }
    }
  }

  Future<String> _getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}";
      }
      return "Unknown location";
    } catch (e) {
      return "Location not found";
    }
  }

  void _showBidPriceDialog(BuildContext context, int travelId) {
    TextEditingController bidPriceController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter Your Bid Price"),
          content: TextField(
            controller: bidPriceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Enter bid price",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                String bidPrice = bidPriceController.text.trim();
                double? driverBidPrice = double.tryParse(bidPrice);
                if (driverBidPrice != null) {
                  _submitBidPrice(travelId, driverId, driverBidPrice);
                  Navigator.pop(context);
                }else {
                  debugPrint("Invalid bid price: $bidPrice");
                }
              },
              child: const Text("Accept"),
            ),
          ],
        );
      },
    );
  }

  void _submitBidPrice(int travelId, int driverId, double bidPrice) async {
    try {
      bool success = await bidPriceController.submitBidPrice(travelId, driverId, bidPrice);

      if (success) {
        SnackbarHelper.showSnackbar(title: "Success", message: "Bid price is submitted successfully!");
      } else {
        SnackbarHelper.showSnackbar(title: "Error", message: "Failed to submit bid price.", backgroundColor: Colors.red);
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Text(errorMessage!, style: const TextStyle(fontSize: 16)))
              : rideRequests.isEmpty //Check if ride requests are empty
                  ? const Center( 
                      child: Text( 
                        'No Rider Request', 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), 
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: rideRequests.length,
                      itemBuilder: (context, index) {
                        final request = rideRequests[index];

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              "Ride Request #${request.travelId}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("📍Pickup: ${request.pickupAddress ?? 'Fetching...'}"),
                                Text("📍Dropoff: ${request.destinationAddress ?? 'Fetching...'}"),
                                Text("👤Rider: ${request.user!.name}"),
                                Text("📞Phone: ${request.user!.phone ?? 'N/A'}"),
                              ],
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                              ),
                              onPressed: () => _showBidPriceDialog(context, request.travelId!),
                              child: const Text("Bid Price"),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}