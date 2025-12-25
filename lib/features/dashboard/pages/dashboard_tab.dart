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
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  // Navigator.push(
                  //   // context,
                  //   // MaterialPageRoute(builder: (_) => const ProfilePage()),
                  // );
                  break;

                case 'settings':
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => const SettingsPage()),
                  // );
                  break;

                case 'logout':
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LandingPage()),
                    (route) => false,
                  );
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, size: 20),
                    SizedBox(width: 10),
                    Text('Profile'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, size: 20),
                    SizedBox(width: 10),
                    Text('Settings'),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 20, color: Colors.red),
                    SizedBox(width: 10),
                    Text('Logout', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
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
                  value: '2',
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
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ActionButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
