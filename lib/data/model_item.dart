class Item {
  final String id;
  final String name;
  final String barcode;
  final double price;
  final int quantity;

  Item({
    required this.id,
    required this.name,
    required this.barcode,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'barcode': barcode,
      'price': price,
      'quantity': quantity,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      barcode: map['barcode'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}
