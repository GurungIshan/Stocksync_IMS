import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final stock = index < 2 ? 5 : 120; // simulate low stock

          return ListTile(
            tileColor: Colors.grey.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: Icon(
              Icons.inventory,
              color: stock < 10 ? Colors.red : Colors.blue,
            ),
            title: Text('Product ${index + 1}'),
            subtitle: Text('Stock: $stock'),
            trailing: stock < 10
                ? const Text('LOW', style: TextStyle(color: Colors.red))
                : null,
          );
        },
      ),
    );
  }
}
