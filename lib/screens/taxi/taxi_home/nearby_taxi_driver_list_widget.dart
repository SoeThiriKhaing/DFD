import 'package:dailyfairdeal/screens/taxi/taxi_home/nearby_taxi_driver_card.dart';
import 'package:flutter/material.dart';

class NearbyTaxiDriverListWidget extends StatelessWidget {
  final List<Map<String, String?>>  driversList;
  final bool isLoading;
  final void Function(Map<String, String?> driver) onDriverAccepted;

  const NearbyTaxiDriverListWidget({
    super.key,
    required this.driversList,
    required this.isLoading,
    required this.onDriverAccepted,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (driversList.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Waiting for nearby taxi drivers to respond...'),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Nearby Taxi Drivers',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: driversList.length,
            itemBuilder: (context, index) {
              final driver = driversList[index];
              return NearbyTaxiDriverCard(
                driver: driver,
                onAccept: onDriverAccepted,
              );
            },
          ),
        ),
      ],
    );
  }
}
