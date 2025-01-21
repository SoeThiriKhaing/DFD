import 'package:flutter/material.dart';

class AddressSelection extends StatelessWidget {
  final List<Map<String, String>> countryList;
  final List<Map<String, String>> divisionList;
  final List<Map<String, String>> cityList;
  final List<Map<String, String>> townshipList;
  final List<Map<String, String>> wardList;
  final List<Map<String, String>> streetList;

  final int? selectedCountryId;
  final int? selectedDivisionId;
  final int? selectedCityId;
  final int? selectedTownshipId;
  final int? selectedWardId;
  final int? selectedStreetId;

  final Function(String) onCountryChange;
  final Function(String) onDivisionChange;
  final Function(String) onCityChange;
  final Function(String) onTownshipChange;
  final Function(String) onWardChange;
  final Function(String) onStreetChange;

  const AddressSelection({
    super.key,
    required this.countryList,
    required this.divisionList,
    required this.cityList,
    required this.townshipList,
    required this.wardList,
    required this.streetList,
    required this.selectedCountryId,
    required this.selectedDivisionId,
    required this.selectedCityId,
    required this.selectedTownshipId,
    required this.selectedWardId,
    required this.selectedStreetId,
    required this.onCountryChange,
    required this.onDivisionChange,
    required this.onCityChange,
    required this.onTownshipChange,
    required this.onWardChange,
    required this.onStreetChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildDropdownField(
          'Select Country',
          countryList,
          selectedCountryId,
          onCountryChange,
        ),
        buildDropdownField(
          'Select Division',
          divisionList,
          selectedDivisionId,
          onDivisionChange,
        ),
        buildDropdownField(
          'Select City',
          cityList,
          selectedCityId,
          onCityChange,
        ),
        buildDropdownField(
          'Select Township',
          townshipList,
          selectedTownshipId,
          onTownshipChange,
        ),
        buildDropdownField(
          'Select Ward',
          wardList,
          selectedWardId,
          onWardChange,
        ),
        buildDropdownField(
          'Select Street',
          streetList,
          selectedStreetId,
          onStreetChange,
        ),
      ],
    );
  }

  Widget buildDropdownField(
      String label,
      List<Map<String, String>> items,
      int? selectedId,
      Function(String) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedId == null ? null : items.firstWhere((item) => item['id'] == selectedId.toString())['name'],
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item['name'],
          child: Text(item['name']!),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      decoration: InputDecoration(labelText: label),
    );
  }
}
