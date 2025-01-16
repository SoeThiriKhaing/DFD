import 'dart:convert';
import 'package:dailyfairdeal/screens/dashboard/drawer/restaurant_owner_drawer.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({super.key});

  @override
 State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _restaurantNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _blockNoController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedRestaurantType;
  String? _openTime;
  String? _closeTime;
  String? _selectedStreet;

  // Fetch restaurant data
  Future<void> fetchRestaurantData() async {
    try {
      final response = await http.get(Uri.parse('http://api.dailyfairdeal.com/api/restaurant'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          _restaurantNameController.text = data['name'];
          _ownerNameController.text = data['addressData']['owner_name'];
          _phoneNumberController.text = data['phone_number'];
          _blockNoController.text = data['addressData']['block_no'];
          _floorController.text = data['addressData']['floor'];
          _selectedRestaurantType = data['restaurant_type_id'].toString();
          _openTime = data['open_time'];
          _closeTime = data['close_time'];
          _selectedStreet = data['addressData']['street_id'].toString();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // Open time picker
  Future<void> _selectTime(BuildContext context, bool isOpenTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        final formattedTime = picked.format(context);
        if (isOpenTime) {
          _openTime = formattedTime;
        } else {
          _closeTime = formattedTime;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRestaurantData();
  }

  @override
  void dispose() {
    _restaurantNameController.dispose();
    _ownerNameController.dispose();
    _phoneNumberController.dispose();
    _blockNoController.dispose();
    _floorController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Setting', style: AppWidget.subTitle()),
        backgroundColor: AppColor.primaryColor,
      ),
      drawer: const RestaurantOwnerDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Restaurant Name
                TextFormField(
                  controller: _restaurantNameController,
                  decoration: const InputDecoration(labelText: 'Restaurant Name'),
                  validator: (value) => value!.isEmpty ? 'Enter restaurant name' : null,
                ),

                // Restaurant Type Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedRestaurantType,
                  decoration: const InputDecoration(labelText: 'Restaurant Type'),
                  items: ['1', '2', '3']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text('Type $type'),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedRestaurantType = value),
                ),

                // Owner Name
                TextFormField(
                  controller: _ownerNameController,
                  decoration: const InputDecoration(labelText: 'Owner Name'),
                  validator: (value) => value!.isEmpty ? 'Enter owner name' : null,
                ),

                // Phone Number
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: (value) => value!.isEmpty ? 'Enter phone number' : null,
                ),

                // Open Time
                ListTile(
                  title: Text('Open Time: ${_openTime ?? 'Select Time'}'),
                  trailing: const Icon(Icons.access_time),
                  onTap: () => _selectTime(context, true),
                ),

                // Close Time
                ListTile(
                  title: Text('Close Time: ${_closeTime ?? 'Select Time'}'),
                  trailing: const Icon(Icons.access_time),
                  onTap: () => _selectTime(context, false),
                ),

                // Address Fields
                DropdownButtonFormField<String>(
                  value: _selectedStreet,
                  decoration: const InputDecoration(labelText: 'Street'),
                  items: ['1', '2', '3']
                      .map((street) => DropdownMenuItem(
                            value: street,
                            child: Text('Street $street'),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedStreet = value),
                ),

                TextFormField(
                  controller: _blockNoController,
                  decoration: const InputDecoration(labelText: 'Block No'),
                  validator: (value) => value!.isEmpty ? 'Enter block number' : null,
                ),

                TextFormField(
                  controller: _floorController,
                  decoration: const InputDecoration(labelText: 'Floor'),
                  validator: (value) => value!.isEmpty ? 'Enter floor' : null,
                ),

                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),

                const SizedBox(height: 20),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Get.snackbar("Success", "Profile updated successfully", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
