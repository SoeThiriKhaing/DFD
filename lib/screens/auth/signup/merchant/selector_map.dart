import 'package:flutter/material.dart';

class SelectorMap extends StatelessWidget {
  final String label;
  final String? selectedValue;
  final Future<List<Map<String, String>>> Function() loadItems;
  final ValueChanged<String?> onChanged;

  const SelectorMap({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.loadItems,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: loadItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return Text('No $label available');
        }

        return DropdownButtonFormField<String>(
          value: selectedValue,
          hint: Text('Select a $label'),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item['id'],
              child: Text(item['name'] ?? ''),
            );
          }).toList(),
          onChanged: onChanged,
        );
      },
    );
  }
}
