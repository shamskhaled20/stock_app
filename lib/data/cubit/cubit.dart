import 'package:flutter_bloc/flutter_bloc.dart';

import '../database_helper.dart';
import '../model_item.dart';
import '../model_stock.dart';


class ItemsCubit extends Cubit<List<Item>> {
  ItemsCubit() : super([]);

  Future<void> loadItems() async {
    try {
      final db = DatabaseHelper.instance;
      final items = await db.getItems(); // Implement this function in your database helper
      emit(items);
    } catch (e) {
      print('Error loading items: $e');
    }
  }

  Future<void> addItem(Item item) async {
    try {
      final db = DatabaseHelper.instance;
      await db.insertItem(item);
      final updatedItems = await db.getItems(); // Load updated items
      emit(updatedItems);
    } catch (e) {
      print('Error adding item: $e');
    }
  }

// Add more item-related methods as needed
}

class StockRecordsCubit extends Cubit<List<StockRecord>> {
  StockRecordsCubit() : super([]);

  Future<void> loadStockRecords() async {
    try {
      final db = DatabaseHelper.instance;
      final stockRecords = await db.getStockRecords(); // Implement this function in your database helper
      emit(stockRecords);
    } catch (e) {
      print('Error loading stock records: $e');
    }
  }

  Future<void> addStockRecord(StockRecord record) async {
    try {
      final db = DatabaseHelper.instance;
      await db.insertStockRecord(record);
      final updatedRecords = await db.getStockRecords(); // Load updated stock records
      emit(updatedRecords);
    } catch (e) {
      print('Error adding stock record: $e');
    }
  }

// Add more stock record-related methods as needed
}
