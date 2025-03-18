import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatelessWidget {
  final String driverId = "77"; // Replace with actual driver ID

  const ProfileScreen({super.key});

  Future<void> _deleteAccount(BuildContext context) async {
    final url =
        Uri.parse("http://api.dailyfeardeal.com/api/taxi-drivers/$driverId");

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account deleted successfully.")),
        );

        // Navigate to login or home screen (update accordingly)
        Navigator.pop(context);
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Failed to delete account: ${response.statusCode}")),
        );
      }
    } catch (e) {
      // Handle network errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting account: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            // Profile Image
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/driver.jpg"),
            ),
            const SizedBox(height: 15),

            // Driver Name
            const Text(
              "John Doe",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            // Driver Details
            const SizedBox(height: 10),
            const Text("📞 Phone: +123 456 7890",
                style: TextStyle(fontSize: 16)),
            const Text("✉️ Email: johndoe@email.com",
                style: TextStyle(fontSize: 16)),
            const Text("🚗 Vehicle: Toyota Prius",
                style: TextStyle(fontSize: 16)),
            const Text("📄 License No: ABC123456",
                style: TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            // Edit Profile Button
            ElevatedButton(
              onPressed: () {
                // Edit profile logic
              },
              child: const Text("Edit Profile"),
            ),

            const Spacer(),

            // Delete Account Button
            TextButton(
              onPressed: () => _deleteAccount(context),
              child: const Text(
                "Delete Account",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}