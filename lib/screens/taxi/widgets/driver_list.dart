import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';
import 'package:flutter/material.dart';

class DriverList extends StatelessWidget {
  final List<DriverModel> drivers;
  final bool isLoading;

  const DriverList({
    super.key,
    required this.drivers,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 100.0,
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (drivers.isEmpty) {
      return const SizedBox(
        height: 100.0,
        child: Center(child: Text('No nearby drivers found.')),
      );
    } else {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Nearby Taxi Drivers',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: drivers.length,
              itemBuilder: (BuildContext context, int index) {
                final driver = drivers[index];
                return ListTile(
                  title: Text(driver.name ?? 'Unknown Driver'),
                  subtitle: Text('Car No: ${driver.licensePlate} \nPrice: ${driver.price} MMK'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Handle accept button press
                    },
                    child: const Text('Accept'),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}