// Stock Record class (similar to Item class)
class StockRecord {
  final int documentNumber;
  final String recordTime;
  final String itemID;
  final int itemQuantity;

  StockRecord({
    required this.documentNumber,
    required this.recordTime,
    required this.itemID,
    required this.itemQuantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'document_number': documentNumber,
      'record_time': recordTime,
      'item_id': itemID,
      'item_quantity': itemQuantity,
    };
  }

  factory StockRecord.fromMap(Map<String, dynamic> map) {
    return StockRecord(
      documentNumber: map['document_number'],
      recordTime: map['record_time'],
      itemID: map['item_id'],
      itemQuantity: map['item_quantity'],
    );
  }
}
