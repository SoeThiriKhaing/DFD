import 'package:flutter/material.dart';

Widget buildSelectedDriverInfoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              value ?? '-',
              style: const TextStyle(fontSize: 14.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }