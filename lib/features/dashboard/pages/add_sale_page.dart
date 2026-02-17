import 'package:flutter/material.dart';

class AddSalePage extends StatefulWidget {
  const AddSalePage({super.key});

  @override
  State<AddSalePage> createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  String selectedProduct = 'Product 1';
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Sale')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField(
              value: selectedProduct,
              items: List.generate(
                10,
                (i) => DropdownMenuItem(
                  value: 'Product ${i + 1}',
                  child: Text('Product ${i + 1}'),
                ),
              ),
              onChanged: (val) {
                setState(() => selectedProduct = val.toString());
              },
              decoration: const InputDecoration(labelText: 'Product'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
              onChanged: (val) => quantity = int.parse(val),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sale Registered')),
                );
                Navigator.pop(context);
              },
              child: const Text('Submit Sale'),
            ),
          ],
        ),
      ),
    );
  }
}
