import 'package:flutter/material.dart';

class SelectorMap extends StatefulWidget {
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
  State<SelectorMap> createState() => _SelectorMapState();
}

class _SelectorMapState extends State<SelectorMap> {
  List<Map<String, String>> items = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDropdownItems();
  }

  Future<void> _loadDropdownItems() async {
    final loadedItems = await widget.loadItems();
    setState(() {
      items = loadedItems;
      isLoading = false; // Remove loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.selectedValue,
      hint: Text('Select a ${widget.label}'),
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
      onChanged: widget.onChanged,
    );
  }
}
