import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/cubit/cubit.dart';
import '../data/model_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Stocktaking App'),
        ),
        body: Column(
          children: [
            DocumentNumberWidget(),
            BarcodeInputWidget(),
            QuantityInputWidget(),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // Your problematic widget that requires layout information
                return AddItemButton();
              },
            ),
            DocumentItemsListWidget(),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // Your problematic widget that requires layout information
                return SaveButton();
              },
            ),
            BarcodeLookupWidget(),
          ],
        ),
      ),
    );
  }
}

class DocumentNumberWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement UI for displaying the current document number (#1)
    return Text('Document Number: 1'); // Replace '1' with the actual document number.
  }
}

class BarcodeInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement UI for barcode input (#2)
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter Barcode (#2)'),
    );
  }
}

class QuantityInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement UI for quantity input (#3)
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter Quantity (#3)'),
    );
  }
}

class AddItemButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Implement logic to add the item to the list (#4)
        final itemsCubit = context.read<ItemsCubit>();
        // Get the barcode and quantity entered by the user
        // Call the cubit method to add the item
      },
      child: Text('Add Item (#4)'),
    );
  }
}

class DocumentItemsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsCubit, List<Item>>(
      builder: (context, items) {
        // Implement UI for displaying items in the document (#5)
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
    );
  }
}

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Implement logic to save the document and update the database (#6)
        final itemsCubit = context.read<ItemsCubit>();
        // Call the cubit method to save the document
      },
      child: Text('Save Document (#6)'),
    );
  }
}

class BarcodeLookupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement UI for barcode lookup (#7)
    return TextFormField(
      decoration: InputDecoration(labelText: 'Lookup Barcode (#7)'),
    );
  }
}