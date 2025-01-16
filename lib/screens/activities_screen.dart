
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.primaryColor, // Updated color
          title: Text('Activities', style: AppWidget.appBarTextStyle()),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3.0,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            tabs: [
              Tab(
                icon: Icon(Icons.fastfood, size: 24),
                text: 'Food',
              ),
              Tab(
                icon: Icon(Icons.local_taxi, size: 24),
                text: 'Taxi',
              ),
              Tab(
                icon: Icon(Icons.store, size: 24),
                text: 'Mall',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FoodActivities(),
            TaxiActivities(),
            MallActivities(),
          ],
        ),
      ),
    );
  }
}

class FoodActivities extends StatelessWidget {
  const FoodActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        ActivityCard(
          icon: Icons.fastfood,
          title: 'Order #12345',
          subtitle: 'Status: Out for Delivery',
          trailing: 'ETA: 20 mins',
        ),
        ActivityCard(
          icon: Icons.fastfood,
          title: 'Order #12344',
          subtitle: 'Status: Delivered',
          trailing: 'Yesterday',
        ),
      ],
    );
  }
}

class TaxiActivities extends StatelessWidget {
  const TaxiActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        ActivityCard(
          icon: Icons.local_taxi,
          title: 'Ride to Downtown',
          subtitle: 'Driver: John Doe',
          trailing: 'Ongoing',
        ),
        ActivityCard(
          icon: Icons.local_taxi,
          title: 'Ride to Airport',
          subtitle: 'Completed',
          trailing: '2 days ago',
        ),
      ],
    );
  }
}

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

class ActivityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String trailing;

  const ActivityCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColor.primaryColor.withOpacity(0.2),
          child: Icon(icon, color: AppColor.primaryColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Text(
          trailing,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

