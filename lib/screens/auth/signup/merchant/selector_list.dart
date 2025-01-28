import 'package:flutter/material.dart';

class SelectorList extends StatelessWidget {
  final String label;
  final dynamic selectedValue;
  final Future<List<dynamic>> Function() loadItems;
  final ValueChanged<dynamic> onChanged;
  final String Function(dynamic)? itemToString;
  final String Function(dynamic)? valueExtractor;

  const SelectorList({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.loadItems,
    required this.onChanged,
    this.itemToString = defaultItemToString,
    this.valueExtractor = defaultValueExtractor,
  });

  // Default function to convert the item to a string (you can customize it)
  static String defaultItemToString(dynamic item
  ) {
    return item.toString();
  }

  // Default function to extract a value (you can customize it)
  static String defaultValueExtractor(dynamic item) {
    return item.toString();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
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

        return DropdownButtonFormField<dynamic>(
          value: selectedValue,
          hint: Text('Select a $label'),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
          items: items.map((item) {
            return DropdownMenuItem<dynamic>(
              value: valueExtractor!(item),
              child: Text(itemToString!(item)),
            );
          }).toList(),
          onChanged: onChanged,
        );
      },
    );
  }
}
