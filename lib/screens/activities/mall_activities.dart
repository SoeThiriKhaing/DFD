import 'package:dailyfairdeal/screens/activities_screen.dart';
import 'package:flutter/material.dart';

class MallActivities extends StatelessWidget {
  const MallActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        ActivityCard(
          icon: Icons.shopping_cart,
          title: 'Shopping at Fashion Store',
          subtitle: 'Purchase Total: \$120',
          trailing: '1 hour ago',
        ),
        ActivityCard(
          icon: Icons.shopping_cart,
          title: 'Shopping at Electronics',
          subtitle: 'Purchase Total: \$450',
          trailing: '3 days ago',
        ),
      ],
    );
  }
}