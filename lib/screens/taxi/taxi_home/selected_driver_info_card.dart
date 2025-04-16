import 'package:dailyfairdeal/screens/taxi/taxi_home/build_selected_driver_info_row_widget.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _callDriver(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not launch phone call");
    }
  }

  void _textDriver(String phoneNumber) async {
    final uri = Uri.parse('sms:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not launch SMS");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 6.0,
        shadowColor: Colors.grey.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 36.0,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Text(
                      driverInfo['driver_name'] ?? '',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Driver Information',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12.0),
              buildSelectedDriverInfoRow(
                  'License Plate', driverInfo['license_plate']),
              buildSelectedDriverInfoRow(
                  'Phone Number', driverInfo['driver_phone']),
              buildSelectedDriverInfoRow('Price', '${driverInfo['price']} MMK'),
              const SizedBox(height: 20.0),

              // Buttons Row
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.call,
                        size: 16,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () =>
                          _callDriver(driverInfo['driver_phone'] ?? ''),
                      label: const Text('Call',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.message,
                        size: 16,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () =>
                          _textDriver(driverInfo['driver_phone'] ?? ''),
                      label: const Text('Text',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12.0),

              // Complete Trip Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: showCompleteTrip ? onCompleteTrip : null,
                  child: const Text(
                    'Complete Trip',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
