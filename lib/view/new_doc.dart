import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/cubit/cubit.dart';
import '../data/database_helper.dart';
import '../data/model_item.dart';

class NewDocScreen extends StatefulWidget {
  const NewDocScreen({Key? key}) : super(key: key);

  @override
  _NewDocScreenState createState() => _NewDocScreenState();
}

class _NewDocScreenState extends State<NewDocScreen> {
  final barcodeController = TextEditingController();
  final quantityController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  void dispose() {
    barcodeController.dispose();
    quantityController.dispose();
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Document'),
      ),
      body: Column(
        children: [
          Text('Document Number: 1'),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: barcodeController,
                  decoration: InputDecoration(labelText: 'Enter Barcode (#2)'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: quantityController,
                  decoration: InputDecoration(labelText: 'Enter Quantity (#3)'),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              final barcode = barcodeController.text;
              final quantity = int.tryParse(quantityController.text) ?? 1;

              // Load item details based on barcode
              final item = await databaseHelper.loadItemByBarcode(barcode);

              if (item != null) {
                // Create a new item with details
                final newItem = Item(
                  id: 'unique_id', // Generate a unique ID
                  name: item.name,
                  barcode: barcode,
                  price: item.price,
                  quantity: quantity,
                );

                // Add the new item to the ItemsCubit
                context.read<ItemsCubit>().addItem(newItem);

                // Clear the input fields and reset quantity to 1
                nameController.clear();
                priceController.clear();
                quantityController.text = '1';
              } else {
                // Handle the case when the barcode does not match any items
                // You can show an error message to the user
                // For example, using ScaffoldMessenger or a dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item with barcode $barcode not found.'),
                  ),
                );
              }
            },
            child: Text('Add Item (#4)'),
          ),
          Expanded(
            child: BlocBuilder<ItemsCubit, List<Item>>(
              builder: (context, items) {
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text('Quantity: ${item.quantity}'),
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final itemsCubit = context.read<ItemsCubit>();
              final items = await itemsCubit.state;

              // Add your logic to save items in 'items' to the database
              for (final item in items) {
                await databaseHelper.insertItem(item);
              }

              // Clear the input fields and reset quantity to 1
              nameController.clear();
              priceController.clear();
              barcodeController.clear();
              quantityController.text = '1';

              // After saving, navigate back to the main menu or perform your desired action
              // For example, you can use Navigator to go back to the main menu
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
