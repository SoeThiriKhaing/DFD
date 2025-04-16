import 'dart:async';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/rider_request/build_price_dialog.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/rider_request/ride_request_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/controllers/taxi/travel/travel_controller.dart';
import 'package:dailyfairdeal/controllers/taxi/bid_price/bid_price_controller.dart';
import 'package:dailyfairdeal/services/taxi/travel/travel_service.dart';
import 'package:dailyfairdeal/services/taxi/bid_price/bid_price_service.dart';
import 'package:dailyfairdeal/repositories/taxi/travel/travel_repository.dart';
import 'package:dailyfairdeal/repositories/taxi/bid_price/bid_price_repository.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/get_address_from_latlong.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/driver_dashboard.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';

class RideRequest extends StatefulWidget {
  const RideRequest({super.key});

  @override
  State<RideRequest> createState() => _RideRequestState();
}

class _RideRequestState extends State<RideRequest> {
  late int driverId;
  late TravelController travelController;
  late BidPriceController bidPriceController;
  List<TravelModel> rideRequests = [];
  bool isLoading = true;
  String? errorMessage;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    String? taxiDriverId = await getDriverId();
    driverId = int.parse(taxiDriverId!);
    travelController = Get.put(TravelController(
        travelService: TravelService(travelRepository: TravelRepository())));
    bidPriceController = Get.put(BidPriceController(
        bidPriceService:
            BidPriceService(bidPriceRepository: BidPriceRepository())));
    _fetchRideRequests();
    _timer =
        Timer.periodic(const Duration(seconds: 3), (_) => _fetchRideRequests());
  }

  Future<void> _fetchRideRequests() async {
    try {
      List<TravelModel> requests =
          await travelController.fetchRiderRequests(driverId);
      for (var request in requests) {
        request.pickupAddress = await getAddressFromLatLng(
            request.pickupLatitude, request.pickupLongitude);
        request.destinationAddress = await getAddressFromLatLng(
            request.destinationLatitude, request.destinationLongitude);
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

  void _submitBidPrice(int travelId, double bidPrice) async {
    try {
      bool success =
          await bidPriceController.submitBidPrice(travelId, driverId, bidPrice);
      SnackbarHelper.showSnackbar(
        title: success ? "Success" : "Error",
        message: success
            ? "Bid price submitted successfully!"
            : "Failed to submit bid price.",
        // backgroundColor: success ? null : AppColor.primaryColor,
      );
    } catch (e) {
      debugPrint("Bid submission error: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DriverDashboard(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child:
                      Text(errorMessage!, style: const TextStyle(fontSize: 16)))
              : rideRequests.isEmpty
                  ? const Center(
                      child: Text('No Rider Request',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: rideRequests.length,
                      itemBuilder: (context, index) {
                        return RideRequestCard(
                          request: rideRequests[index],
                          onSubmitBid: (travelId) => showBidPriceDialog(
                            context: context,
                            onSubmit: (bidPrice) =>
                                _submitBidPrice(travelId, bidPrice),
                            travelId: travelId,
                          ),
                        );
                      },
                    ),
    );
  }
}
