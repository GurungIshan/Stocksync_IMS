import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../auth/presentation/bloc/auth_bloc.dart';
// import '../../auth/presentation/bloc/auth_event.dart';
import '../../auth/presentation/pages/landing_page.dart';
import 'add_sale_page.dart';
import '../widget/stat_card.dart';
import '../widget/action_button.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LandingPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: const [
                StatCard(
                  title: 'Total Products',
                  value: '120',
                  icon: Icons.inventory,
                  color: Colors.blue,
                ),
                SizedBox(width: 12),
                StatCard(
                  title: 'Low Stock',
                  value: '8',
                  icon: Icons.warning,
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                StatCard(
                  title: 'Today Sales',
                  value: 'Rs. 25,000',
                  icon: Icons.money,
                  color: Colors.green,
                ),
                SizedBox(width: 12),
                StatCard(
                  title: 'Invoices',
                  value: '14',
                  icon: Icons.receipt,
                  color: Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// USER ACTION
            ActionButton(
              icon: Icons.add_shopping_cart,
              label: 'Register Sale',
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddSalePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
