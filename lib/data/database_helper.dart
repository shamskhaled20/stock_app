import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model_item.dart';
import 'model_stock.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'stocktaking.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE items (
            id TEXT PRIMARY KEY,
            name TEXT,
            barcode TEXT UNIQUE,
            price REAL,
            quantity INTEGER
          )
        ''');
        db.execute('''
          CREATE TABLE stock_records (
            document_number INTEGER PRIMARY KEY,
            record_time TEXT,
            item_id TEXT,
            item_quantity INTEGER,
            FOREIGN KEY (item_id) REFERENCES items (id)
          )
        ''');
      },
    );
  }

  Future<List<Item>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('items');
    return List.generate(maps.length, (index) {
      return Item(
        id: maps[index]['id'],
        name: maps[index]['name'],
        barcode: maps[index]['barcode'],
        price: maps[index]['price'],
        quantity: maps[index]['quantity'],
      );
    });
  }

  Future<void> insertItem(Item item) async {
    final db = await database;
    await db.insert('items', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<StockRecord>> getStockRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('stock_records');
    return List.generate(maps.length, (index) {
      return StockRecord(
        documentNumber: maps[index]['document_number'],
        recordTime: maps[index]['record_time'],
        itemID: maps[index]['item_id'],
        itemQuantity: maps[index]['item_quantity'],
      );
    });
  }

  Future<void> insertStockRecord(StockRecord record) async {
    final db = await database;
    await db.insert('stock_records', record.toMap());
  }
  Future<Item?> loadItemByBarcode(String barcode) async {
    final db = await database;
    final result = await db.query(
      'items',
      where: 'barcode = ?',
      whereArgs: [barcode],
    );

    if (result.isEmpty) {
      return null; // Return null if no item with the provided barcode is found
    }

    return Item.fromMap(result.first);
  }
// Add more database operations as needed
}
