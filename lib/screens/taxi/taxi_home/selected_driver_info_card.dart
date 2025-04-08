import 'package:dailyfairdeal/screens/taxi/taxi_home/build_selected_driver_info_row_widget.dart';
import 'package:flutter/material.dart';

class SelectedDriverInfoCard extends StatelessWidget {
  final Map<String, dynamic> driverInfo;
  final bool showCompleteTrip;
  final VoidCallback? onCompleteTrip;

  const SelectedDriverInfoCard({
    super.key,
    required this.driverInfo,
    this.showCompleteTrip = false,
    this.onCompleteTrip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          const SizedBox(height: 12.0),
          const Text(
            'Driver Information',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12.0),

          buildSelectedDriverInfoRow('Name', driverInfo['driver_name']),
          buildSelectedDriverInfoRow('License Plate', driverInfo['license_plate']),
          buildSelectedDriverInfoRow('Phone Number', driverInfo['driver_phone']),
          buildSelectedDriverInfoRow('Price', '${driverInfo['price']} MMK'),

          const SizedBox(height: 16.0),

          ElevatedButton(
            onPressed: showCompleteTrip ? onCompleteTrip : null,
            child: const Text(
              'Complete Trip',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }

}
