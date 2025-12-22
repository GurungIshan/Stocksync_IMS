import 'package:flutter/material.dart';
// import 'add_sale_page.dart';

class SalesTab extends StatelessWidget {
  const SalesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (_) => const AddSalePage()),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 10, // mock data
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: Colors.grey.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: const Icon(Icons.receipt_long),
            title: Text('Invoice #00${index + 1}'),
            subtitle: const Text('Amount: Rs. 2,500'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          );
        },
      ),
    );
  }
}
