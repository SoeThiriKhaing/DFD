import 'package:dailyfairdeal/controllers/taxi/driver/travel_controller.dart';
import 'package:dailyfairdeal/models/taxi/driver/travel_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/travel_repository.dart';
import 'package:dailyfairdeal/services/taxi/driver/travel_service.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideRequestsScreen extends StatefulWidget {
  final String driverId;

  const RideRequestsScreen({super.key, required this.driverId});

  @override
  RideRequestsScreenState createState() => RideRequestsScreenState();
}

class RideRequestsScreenState extends State<RideRequestsScreen> {
  late TravelController travelController;
  List<TravelModel> rideRequests = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    travelController = Get.put(TravelController(
        travelService:
            TravelService(travelRepository: TravelRepository())));
    _fetchRideRequests();
  }

  Future<void> _fetchRideRequests() async {
    try {
      List<TravelModel> requests = await travelController.fetchRideRequests();
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

  void _acceptRide(int id, BuildContext context) {
    // Implement ride acceptance logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Accepted ride request #$id")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child:
                      Text(errorMessage!, style: const TextStyle(fontSize: 16)))
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
                        leading: const Icon(Icons.location_on,
                            color: AppColor.primaryColor, size: 30),
                        title: Text(
                          "Ride Request #${request.travelId}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "📍 Pickup: ${request.pickupLatitude}, ${request.pickupLongitude}"),
                            Text(
                                "📍 Dropoff: ${request.destinationLatitude}, ${request.destinationLongitude}"),
                            Text("👤 Rider: ${request.user.name}"),
                            //Text("📞 Phone: ${request.user.phoneNo}"),
                          ],
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                          ),
                          onPressed: () =>
                              _acceptRide(request.travelId!, context),
                          child: const Text("Accept"),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}