import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/cubit/cubit.dart';
import '../data/model_item.dart'; // Import your Cubits

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  final barcodeController = TextEditingController();
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void dispose() {
    barcodeController.dispose();
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void fetchItemDetails(String barcode) async {
    final itemsCubit = context.read<ItemsCubit>();
    final items = await itemsCubit.state;
    final item = items.firstWhere((item) => item.barcode == barcode, orElse: () => Item(id: '', name: '', barcode: '', price: 0.0, quantity: 0));

    nameController.text = item.name;
    quantityController.text = item.quantity.toString();
    priceController.text = item.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: barcodeController,
            decoration: InputDecoration(labelText: 'Enter Barcode (#7)'),
            onChanged: (barcode) {
              fetchItemDetails(barcode);
            },
          ),
          const SizedBox(height: 10),
          Text("Name:"),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name (#8)'),
            enabled: false, // Disable editing
          ),
          Text("Quantity:"),
          TextFormField(
            controller: quantityController,
            decoration: InputDecoration(labelText: 'Quantity (#9)'),
            enabled: false, // Disable editing
          ),
          Text("Price:"),
          TextFormField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Price (#10)'),
            enabled: false, // Disable editing
          ),
        ],
      ),
    );
  }
}

